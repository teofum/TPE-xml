let $congress := collection("dir.xml")//congress
return <data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="congress_data.xsd">
  <congress>
    <name number="{fn:normalize-space($congress/number)}">
      {fn:normalize-space($congress/name)}
    </name>

    <period
      from="{fn:normalize-space($congress/startYear)}"
      to="{fn:normalize-space($congress/endYear)}"
    />

    {$congress/url}

    <chambers>
    </chambers>
  </congress>
</data>