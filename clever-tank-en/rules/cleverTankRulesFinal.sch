<?xml version="1.0" encoding="UTF-8"?>

<!-- Created by FJK for DITA Users Meetup Freiburg   -->
<!-- Destroyed by GitHub on 2017-07-14 at 17:30 MESZ -->
<!-- Recreated by FJK beginning at 17:32             -->

<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

    <sch:pattern>
        <sch:rule context="text()" id="CTProdName">
            <sch:report role="error" test="
                matches(., 'CleverTank\s\d+')"
                sqf:fix="ct01">Product Name Text not allowed: Change it to
                keyword/keyref.</sch:report>
            <sqf:fix id="ct01">
                <sqf:description>
                    <sqf:title>Change to Keyword/KeyRef!</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CleverTank\s\d+"><keyword keyref="prod-name"
                    /></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="text()" id="CTProdShortname">
            <sch:report role="error" test="matches(., 'CT\d+')" sqf:fix="ct02">Product Shortname
                Text not allowed: Change it to keyword/keyref.</sch:report>
            <sqf:fix id="ct02">
                <sqf:description>
                    <sqf:title>Change to Keyword/KeyRef!</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CT\d+"><keyword keyref="prod-short"
                    /></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="text()" id="CTRuleProdSeries">
            <sch:report role="error" test="matches(., 'CleverTank\(.\D\)')" sqf:fix="ct03">Product Series
                Text not allowed: Change it to keyword/keyref.</sch:report>
            <sqf:fix id="ct03">
                <sqf:description>
                    <sqf:title>Change to Keyword/KeyRef!</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CleverTank\(.\D\)"><keyword keyref="prod-series"
                    />$1</sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>

</sch:schema>
