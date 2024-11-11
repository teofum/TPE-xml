#!/bin/bash

API_KEY="rC8VcAUHFUzou8YrWCv0LEZ0zFgqdxGZmcXrLxr0"
BASE_URL="https://api.congress.gov/v3"
QUERY="format=xml&api_key=$API_KEY"
PAGE_SIZE=250

if [[ $1 == "--clean" ]]; then
  rm -fv congress_info.xml congress_members_info.xml congress_data.xml congress_page.html
  exit 0
fi

congress_number=$1

if (( congress_number < 1 || congress_number > 118 )); then
  echo "Congress number must be between 1 and 118"
  exit 1
fi

# Fetch congress info
echo "Fetching congress info..."
curl "$BASE_URL/congress/$congress_number?$QUERY" -H "accept: application/xml" -o congress_info.xml

# Fetch members info
echo "Fetching congress members info..."
curl "$BASE_URL/member/congress/$congress_number?$QUERY&limit=$PAGE_SIZE" -H "accept: application/xml" -o congress_members_info.xml

# Process data
echo "Processing XML data -> congress_data.xml"
java net.sf.saxon.Query extract_congress_data.xq > congress_data.xml

# Generate HTML
echo "Generating HTML -> congress_page.html"
java net.sf.saxon.Transform congress_data.xml generate_html.xsl > congress_page.html