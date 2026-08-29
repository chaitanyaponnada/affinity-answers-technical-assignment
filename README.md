# Affinity Answers Technical Assignment

This repository contains my solutions for the Affinity Answers Full Stack Engineering technical assignment.

## Technologies

* Python
* SQL
* Unix/Linux Shell Scripting

## Project Structure

```text
technical-assignment/
├── README.md
├── requirements.txt
├── question1/
│   └── scraper.py
├── question2/
│   └── queries.sql
└── question3/
    └── companies.sh
```

## Questions

1. Python Web Scraping
2. SQL and Database Queries
3. Unix Shell Scripting

Each question is organized in its own directory with instructions and implementation details included in this README.

######Question 1 - Python Web Scraping

For this question, I created a Python program that searches for products on the MDComputers website based on a search term entered by the user.

The program extracts and displays:

Product name
Selling price
Requirements
Python 3
requests
beautifulsoup4

Install the required dependencies using:

pip install -r question1/requirements.txt
Running the Program
python question1/scraper.py

The program asks the user to enter a search term and then retrieves the matching products from the website.

Example:

Enter search term: external hard drive

Retrieving search results...

Products found for: external hard drive

The program also handles basic errors such as an empty search term or failure to retrieve the webpage.

#######Question 2 - SQL and Database

For this question, I wrote SQL queries based on the public Rfam MySQL database.

The queries are available in:

question2/queries.sql
Question A

This query counts the number of Acacia plant types present in the taxonomy table.

Question B

This query finds the type of wheat with the longest DNA sequence.

The result includes:

Wheat type
DNA sequence length
Question C

This query finds families where the maximum DNA sequence length is greater than 1,000,000.

The result includes:

Family name
Family accession
Maximum DNA sequence length

The results are sorted by sequence length in descending order. Each page contains 15 results, and the query returns the 9th page of results.

########Question 3 - Unix Shell Scripting

For this question, I created a shell script to process the provided S&P 500 companies CSV dataset.

The script:

Accepts the CSV URL as a command-line argument
Downloads the CSV data
Extracts company name, location, and founding year
Sorts the records by founding year
Displays the results in a readable format
Requirements

The script uses standard Unix utilities including:

curl
awk
sort
tail
Running the Script

First, make the script executable:

chmod +x question3/companies.sh - this is the main step 

Then run:

./question3/companies.sh "DATASET_URL"

Example:

./question3/companies.sh "https://raw.githubusercontent.com/datasets/s-and-p-500-companies/refs/heads/main/data/constituents.csv"

The script also handles basic errors such as a missing URL argument or failure to download the dataset.