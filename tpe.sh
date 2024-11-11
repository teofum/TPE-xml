#!/bin/bash

API_KEY="rC8VcAUHFUzou8YrWCv0LEZ0zFgqdxGZmcXrLxr0"
BASE_URL="https://api.congress.gov/v3"
QUERY="format=xml&api_key=$API_KEY"
PAGE_SIZE=250

rm -f congress_info.xml congress_members_info.xml congress_data.xml congress_page.html
if [[ $1 == "--clean" ]]; then
  exit 0
fi

congress_number=$1

if [[ -n $congress_number ]]; then
  # Fetch congress info
  echo "Fetching congress info..."
  curl "$BASE_URL/congress/$congress_number?$QUERY" -H "accept: application/xml" -o congress_info.xml

  # Fetch members info
  echo "Fetching congress members info..."
  curl "$BASE_URL/member/congress/$congress_number?$QUERY&limit=$PAGE_SIZE" -H "accept: application/xml" -o congress_members_info.xml
else
  echo "Warning: congress number is empty"

  # If congress number is left empty, the APIs return inconsistent results
  # Create a dummy response so the XQuery transform picks up the error
  echo '<?xml version="1.0" encoding="utf-8"?>' > congress_info.xml
  echo '<api-root><error>' >> congress_info.xml
  echo 'Congress number must not be empty' >> congress_info.xml
  echo '</error></api-root>' >> congress_info.xml

  # Just need the members file to not be empty, duplicate the error
  cp congress_info.xml congress_members_info.xml
fi

# Process data
echo "Processing XML data -> congress_data.xml"
java net.sf.saxon.Query extract_congress_data.xq > congress_data.xml

# Generate HTML
echo "Generating HTML -> congress_page.html"
java net.sf.saxon.Transform congress_data.xml generate_html.xsl > congress_page.html