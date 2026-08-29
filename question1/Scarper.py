
import re
from urllib.parse import urlencode

import requests
from bs4 import BeautifulSoup


def build_search_url(search_term):
    #Create the MDComputers search URL.

    parameters = {
        "route": "product/search",
        "search": search_term,
    }

    return "https://mdcomputers.in/?" + urlencode(parameters)


def get_page(url):
    #Download the search results page.

    headers = {
        "User-Agent": "Mozilla/5.0",
    }

    try:
        response = requests.get(url, headers=headers, timeout=20)
        response.raise_for_status()
        return response.text

    except requests.RequestException as error:
        print(f"Error retrieving the page: {error}")
        return None


def extract_products(html):
    #Extract product names and selling prices

    soup = BeautifulSoup(html, "html.parser")
    products = []

    headings = soup.find_all(["h3", "h4"])

    for heading in headings:
        link = heading.find("a")

        if link is None:
            continue

        product_name = link.get_text(strip=True)

        if not product_name or product_name == "×":
            continue

        # Get the product container.
        product = heading.parent.parent
        product_text = product.get_text(" ", strip=True)

        # Find prices starting with ₹.
        prices = re.findall(
            r"₹\s*[\d,]+(?:\.\d{1,2})?",
            product_text,
        )

        if not prices:
            continue

        # Use the last displayed price as selling price.
        selling_price = prices[-1].replace(" ", "")

        products.append({
            "name": product_name,
            "price": selling_price,
        })

    return products


def display_products(search_term, products):
    #Display products clearly

    print(f"\nProducts found for: {search_term}")
    print("-" * 80)

    if not products:
        print("No products found.")
        return

    for number, product in enumerate(products, start=1):
        print(f"{number}. {product['name']}")
        print(f"   Selling Price: {product['price']}")


def main():
    #Run the scraper

    search_term = input("Enter search term: ").strip()

    if not search_term:
        print("Search term cannot be empty.")
        return

    search_url = build_search_url(search_term)

    print("\nRetrieving search results...")

    html = get_page(search_url)

    if html is None:
        return

    products = extract_products(html)
    display_products(search_term, products)


if __name__ == "__main__":
    main()