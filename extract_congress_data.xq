let $congress := doc("congress_info.xml")//congress
let $members := doc("congress_members_info.xml")//members

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
      {
        for $chamber in fn:distinct-values($congress//chamber)
        let $name := fn:normalize-space($chamber)
        return <chamber>
          <name>{$name}</name>
          <members>
            {
              for $member in $members/member[.//fn:normalize-space(chamber) = $name]
              for $term in $member//item[./fn:normalize-space(chamber) = $name]
              return <member bioguideId="{fn:normalize-space($member/bioguideId)}">
                <name>{fn:normalize-space($member/name)}</name>
                <state>{fn:normalize-space($member/state)}</state>
                <party>{fn:normalize-space($member/partyName)}</party>
                <image_url>{fn:normalize-space($member//imageUrl)}</image_url>
                <period
                  from="{fn:normalize-space($term/startYear)}"
                  to="{fn:normalize-space($term/endYear)}"
                />
              </member>
            }
          </members>
          <sessions>
            {
              for $session in $congress/sessions/item[./chamber = $chamber]
              return <session>
                <number>{fn:normalize-space($session/number)}</number>
                <period 
                  from="{fn:normalize-space($session/startDate)}"
                  to="{fn:normalize-space($session/endDate)}"
                />
                <type>{fn:normalize-space($session/type)}</type>
              </session>
            }
          </sessions>
        </chamber>
      }
    </chambers>
  </congress>
</data>