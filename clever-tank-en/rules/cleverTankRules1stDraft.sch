<?xml version="1.0" encoding="UTF-8"?>

<!-- Created by FJK for DITA Users Meetup Freiburg   -->
<!-- Destroyed by GitHub on 2017-07-14 at 17:30 MESZ -->
<!-- Recreated by FJK beginning at 17:32             -->

<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">



    <!-- Prüfen, dass der Text von Shortdesc nicht länger als 140 Zeichen ist -->
    <!-- Hinweis auf aktuelle Länge des Textes ausgeben                       -->
    <sch:pattern>
        <sch:rule context="shortdesc" role="warning">
            <sch:report test="string-length() &gt; 140">Shortdesc should be max. 140 characters. The
                current text length is <sch:value-of select="string-length()"/>
                characters.</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Produktnamen durch keyref (prod-name) ersetzen -->
    <sch:pattern>
        <sch:rule context="text()" id="CleverTankRuleProdName">
            <sch:report role="error" test="
                    matches(., 'CleverTank 1500')"
                sqf:fix="ct01">Der Kurzname des Produkts darf nicht als Text, sondern muss als
                Keyword/Keyref eingegeben werden!</sch:report>
            <sqf:fix id="ct01">
                <sqf:description>
                    <sqf:title>Text Produktname in Keyword/KeyRef ändern...</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CleverTank 1500"><keyword keyref="prod-name"
                    /></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>



    <!-- Seriennamen durch keyrefs (prod-series)ersetzen -->
    <sch:pattern>
        <sch:rule context="text()" id="CleverTankRuleProdSeries">
            <sch:report role="error" test="matches(., 'CleverTank')" sqf:fix="ct03">Der Name der
                Produktserie darf nicht als Text, sondern muss als Keyword/Keyref eingegeben
                werden!</sch:report>
            <sqf:fix id="ct03">
                <sqf:description>
                    <sqf:title>Text Produktserie in Keyword/KeyRef ändern...</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CleverTank"><keyword keyref="prod-series"
                    /></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>

    <!--    Produktkurznamen durch keyre (prod-short) ersetzen -->
    <sch:pattern>
        <sch:rule context="text()" id="CleverTankRuleProdShortname">
            <sch:report role="error" test="matches(., 'CT1500')" sqf:fix="ct02">Der Kurzname des
                Produkts darf nicht als Text, sondern muss als Keyword/Keyref eingegeben
                werden!</sch:report>
            <sqf:fix id="ct02">
                <sqf:description>
                    <sqf:title>Text Produktkurzname in Keyword/KeyRef ändern...</sqf:title>
                </sqf:description>
                <sqf:stringReplace regex="CT1500"><keyword keyref="prod-short"/></sqf:stringReplace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>


    <!--    Prüfe Schreibweise Ribbon = Office2016-Terminologie verwenden -->
    <!--    Historische Änerungen -->
    <sch:pattern>
        <sch:rule context="text()" id="RibbonDescription">
            <sch:report
                test="
                    contains(., 'Funktionsb') or contains(., 'Multifunktionsl')" role="warning"
                >Bitte "Menüband" verwenden, nicht "Multifunktionsleiste" oder
                "Funktonsband".</sch:report>
        </sch:rule>
    </sch:pattern>


</sch:schema>
