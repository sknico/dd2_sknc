proc format;
	value smoke
	0="Aldrig røget"
	1="Eksryger (ophørt for mere end 6 måneder siden)"
	2="Ryger lejlighedsvist"
	3="Ryger dagligt";

value alcohol 
0="Drikker mindre end 7 genstande (kvinder)/ 14 genstande (mænd) per uge"
1="Drikker mere end 7 genstande (kvinder)/ 14 genstande (mænd) per uge";

value physical_act_days
0="Ingen dage"
1="1 dag"
2="2 dage"
3="3 dage"
4="4 dage"
5="5 dage"
6="6 dage"
7="7 dage";

value physical_act_regular
1="Ja"
0="Nej";

value physical_act_lastyear
3="Træner hårdt og dyrker konkurrenceidræt regelmæssigt og flere gange om ugen"
2="Dyrker motionsidræt eller udfører tungt havearbejde eller lignende mindst 4 timer om ugen"
1="Spadserer, cykler eller har anden lettere motion mindst 4 timer om ugen (medregn også søndagsture, lettere havearbejde o" /* ...g cykling/gang til arbejde */
0="Læser, ser fjernsyn eller har anden stillesiddende beskæftigelse";

value walk_unstable
1="Ja"
0="Nej";

value fall_year
1="Ja"
0="Nej";

value fall_how_often
1="1 gang"
2="2-4 gange"
3="Over 4 gange";

value fall_doctor
1="Ja"
0="Nej";

value fall_hospital
1="Ja"
0="Nej";

value qol
0="0. Værst mulige livskvalitet"
1="1."
2="2."
3="3."
4="4."
5="5."
6="6."
7="7."
8="8."
9="9."
10="10. Bedst mulige livskvalitet";

value sleep1_
5="Særdeles dårlig"
4="Dårlig"
3="Nogenlunde"
2="God"
1="Særdeles god";

value sleep2_ 
1="Slet ikke"
2="I mindre grad"
3="I nogen grad"
4="I høj grad"
5="I meget høj grad";

value sleep3_
5="Slet ikke"
4="I mindre grad"
3="I nogen grad"
2="I høj grad"
1="I meget høj grad";

value sleep4_
1="Slet ikke"
2="I mindre grad"
3="I nogen grad"
4="I høj grad"
5="I meget høj grad";

value anxiety1_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value anxiety2_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value anxiety3_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value anxiety4_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value depr1_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value depr2_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value depr3_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value depr4_
1="Aldrig"
2="Sjældent"
3="Sommetider"
4="Ofte"
5="Altid";

value mnsi1_
1="Ja"
0="Nej";

value mnsi2_
1="Ja"
0="Nej";

value mnsi3_ 
1="Ja"
0="Nej";

value x_mnsi4_
1="Ja"
0="Nej";

value mnsi5_
1="Ja"
0="Nej";

value mnsi6_
1="Ja"
0="Nej";

value mnsi7_
0="Ja"
1="Nej";

value mnsi8_
1="Ja"
0="Nej";

value mnsi9_
1="Ja"
0="Nej";

value x_mnsi10_
1="Ja"
0="Nej";

value mnsi11_
1="Ja"
0="Nej";

value mnsi12_
1="Ja"
0="Nej";

value mnsi13_
0="Ja"
1="Nej";

value mnsi14_
1="Ja"
0="Nej";

value mnsi15_
1="Ja"
0="Nej";

value pain 
1="Ja"
0="Nej";

value pain_head
0="Ikke valgt"
1="Valgt";

value pain_back
0="Ikke valgt"
1="Valgt";

value pain_shoulder
0="Ikke valgt"
1="Valgt";

value pain_hands
0="Ikke valgt"
1="Valgt";

value pain_stomach
0="Ikke valgt"
1="Valgt";

value pain_legs
0="Ikke valgt"
1="Valgt";

value pain_other
0="Ikke valgt"
1="Valgt";

value pain_feet
1="Ja"
0="Nej";

value pain_bothfeet
1="Ja"
0="Nej";

value pain_legs
1="Ja"
0="Nej";

value pain_hands
1="Ja"
0="Nej";

value pain_feet_night
1="Ja"
0="Nej";

value pain_feet_dur
1="Mindre end en måned"
2="1-3 måneder"
3="Mere end 3 måneder, men mindre end et et år"
4="1-5 år"
5="Mere end 5 år";

value pain_feet_24h
0="0. Ingen smerte"
1="1."
2="2."
3="3."
4="4."
5="5."
6="6."
7="7."
8="8."
9="9."
10="10. Værst tænkelige smerte";

value pain_feet_7d
0="0. Ingen smerte"
1="1."
2="2."
3="3."
4="4."
5="5."
6="6."
7="7."
8="8."
9="9."
10="10. Værst tænkelige smerte";

value pain_med
1="Ja, dagligt"
2="Ja, men ikke dagligt"
3="Nej";

value prescription_no
0="Ikke valgt"
1="Valgt";

value prescription
0="Ikke valgt"
1="Valgt";

value pain_interference1_
1="Slet ikke"
2="I mindre grad"
3="I nogen grad"
4="I høj grad"
5="I meget høj grad";

value pain_interference2_
1="Slet ikke"
2="I mindre grad"
3="I nogen grad"
4="I høj grad"
5="I meget høj grad";

value pain_interference3_
1="Slet ikke"
2="I mindre grad"
3="I nogen grad"
4="I høj grad"
5="I meget høj grad";

value pain_interference4_
1="Slet ikke"
2="I mindre grad"
3="I nogen grad"
4="I høj grad"
5="I meget høj grad";

value dn4_burning
1="Ja"
0="Nej";

value dn4_cold_pain
1="Ja"
0="Nej";


value dn4_electric_shocks
1="Ja"
0="Nej";

value dn4_tingling
1="Ja"
0="Nej";

value dn4_pins_needles
1="Ja"
0="Nej";


value dn4_numb
1="Ja"
0="Nej";

value dn4_itching
1="Ja"
0="Nej";

value stato_1_
0="Ikke valgt"
1="Valgt";


value $tastet
"BLANK"="BLANK"
"X"="betyder at det er tastet af defactum"
"M"="betyder at det er tastet af defactum og er et mærkeligt skema - fx med bilag"
"A"="betyder at det er tastet af defactum i T2 og T3";




run;



