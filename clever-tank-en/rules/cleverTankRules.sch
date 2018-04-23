<?xml version="1.0" encoding="UTF-8"?>

<!-- Created by FJK for DITA Users Meetup Freiburg   -->
<!-- Destroyed by GitHub on 2017-07-14 at 17:30 MESZ -->
<!-- Recreated by FJK beginning at 17:32             -->

<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:pattern>
        <sch:rule context="text()" id="CleverTankRuleProdName">
            <sch:report role="error" test="matches(., 'CleverTank 1500')" sqf:fix="ct01">Product Name Text not allowed:
                Change it to keyword/keyref.</sch:report>
            <sqf:fix id="ct01">
                <sqf:description>
                    <sqf:title>Change to Keyword/KeyRef!</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CleverTank [0-9]+"><keyword keyref="prod-name"/></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="text()" id="CleverTankRuleProdShortname">
            <sch:report role="error" test="matches(., 'CT1500')" sqf:fix="ct02">Product Shortname Text not allowed:
                Change it to keyword/keyref.</sch:report>
            <sqf:fix id="ct02">
                <sqf:description>
                    <sqf:title>Change to Keyword/KeyRef!</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CT[0-9]+"><keyword keyref="prod-short"/></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <sch:rule context="text()" id="CleverTankRuleProdSeries">
            <sch:report role="error" test="matches(., 'CleverTank')" sqf:fix="ct03">Product Series Text not allowed:
            Change it to keyword/keyref.</sch:report>
            <sqf:fix id="ct03">
                <sqf:description>
                    <sqf:title>Change to Keyword/KeyRef!</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CleverTank"><keyword keyref="prod-series"/></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
 
</sch:schema>