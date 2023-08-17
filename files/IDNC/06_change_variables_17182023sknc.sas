data studypop6;
	set data.studypop5;

	if ryge=1 then smoke=0; 
		else if ryge=2 then smoke=1; 
			else if ryge=3 then smoke=2; 
				else if ryge=4 then smoke=3;

	if alkohol=1 then alcohol=0;
		else if alkohol=2 then alcohol=1;

	if sp5>0 then physical_act_days=sp5-1;
	if sp6>0 then physical_act_regular=sp6-1;

	if sp7=1 then physical_act_lastyear=3;
		else if sp7=2 then physical_act_lastyear=2;
			else if sp7=3 then physical_act_lastyear=1;
				else if sp7=4 then physical_act_lastyear=0;

	if sp8=1 then walk_unstable=1;
		else if sp8=2 then walk_unstable=0;
	
	if sp9=1 then fall_year=1;
		if sp9=2 then fall_year=0;

	if sp9a>0 then fall_how_often=sp9a;

	if sp10=1 then fall_doctor=1;
		else if sp10=2 then fall_doctor=0;

	if sp11=1 then fall_hospital=1;
		else if sp11=2 then fall_hospital=0;

	if sp12>0 then qol=sp12-1;

	if sp13a=1 then sleep1=5;
		else if sp13a=2 then sleep1=4;
			else if sp13a=3 then sleep1=3;
				else if sp13a=4 then sleep1=2;
					else if sp13a=5 then sleep1=1;

 	if sp13b>0 then sleep2=sp13b;

	if sp13c=1 then sleep3=5;
		else if sp13c=2 then sleep3=4;
			else if sp13c=3 then sleep3=3;
				else if sp13c=4 then sleep3=2;
					else if sp13c=5 then sleep3=1;

 	if sp13d>0 then sleep4=sp13d;

	if sp14a>0 then anxiety1=sp14a;
	if sp14b>0 then anxiety2=sp14b;
	if sp14c>0 then anxiety3=sp14c;
	if sp14d>0 then anxiety4=sp14d;

	if sp14e>0 then depr1=sp14e;
	if sp14f>0 then depr2=sp14f;
	if sp14g>0 then depr3=sp14g;
	if sp14h>0 then depr4=sp14h;

	if 				sp15=1 	then mnsi1=1;
		else if sp15=2 	then mnsi1=0;

	if 				sp16=1 	then mnsi2=1;
		else if sp16=2 	then mnsi2=0;

	if 				sp17=1 	then mnsi3=1;
		else if sp17=2 	then mnsi3=0;

	if 				sp18=1 	then x_mnsi4=1;
		else if sp18=2 	then x_mnsi4=0;

	if 				sp19=1 	then mnsi5=1;
		else if sp19=2 	then mnsi5=0;

	if 				sp20=1 	then mnsi6=1;
		else if sp20=2 	then mnsi6=0;

	if 				sp21=1 	then mnsi7=0;
		else if sp21=2 	then mnsi7=1;

	if 				sp22=1 	then mnsi8=1;
		else if sp22=2 	then mnsi8=0;

	if 				sp23=1 	then mnsi9=1;
		else if sp23=2 	then mnsi9=0;

	if 				sp24=1 	then x_mnsi10=1;
		else if sp24=2 	then x_mnsi10=0;

	if 				sp25=1 	then mnsi11=1;
		else if sp25=2 	then mnsi11=0;

	if 				sp26=1 	then mnsi12=1;
		else if sp26=2 	then mnsi12=0;

 	if				sp27=1 	then mnsi13=0;
		else if sp27=2 	then mnsi13=1;

	if 				sp28=1 	then mnsi14=1;
		else if sp28=2 	then mnsi14=0;

	if 				sp29=1 	then mnsi15=1;
		else if sp29=2 	then mnsi15=0;


	if sp30=1 then pain=1;
		else if sp30=2 then pain=0;

	pain_head			=sp30a_1;
 	pain_back			=sp30a_2;
	pain_shoulder	=sp30a_3;
	pain_arms			=sp30a_4;
	pain_stomach	=sp30a_5;
	pain_legs			=sp30a_6;
	pain_other		=sp30a_7;
	pain_if_other	=sp30ak;

	if sp31=1 then pain_feet=1;
		else if sp31=2 then pain_feet=0;

	if sp32=1 then pain_bothfeet=1;
		else if sp32=2 then pain_bothfeet=0;

	if sp33=1 then pain_spread_upwards=1;
		else if sp33=2 then pain_spread_upwards=0;

	if sp34=1 then pain_hands=1;
		else if sp34=2 then pain_hands=0;

	if sp35=1 then pain_feet_night=1;
		else if sp35=2 then pain_feet_night=0;

	if sp36>0 then pain_feet_dur=sp36;
	if sp37>0 then pain_feet_24h=sp37-1;
	if sp38>0 then pain_feet_7d=sp38-1;
	if sp39>0 then pain_med=sp39;

	prescription_no=sp39a_1;
	prescription=sp39a_2;

	if sp40a>0 then pain_interference1=sp40a;
	if sp40b>0 then pain_interference2=sp40b;
	if sp40c>0 then pain_interference3=sp40c;
	if sp40d>0 then pain_interference4=sp40d;

	if sp41a=1 then dn4_burning=1;
		else if sp41a=2 then dn4_burning=0;

	if sp41b=1 then dn4_cold_pain=1;
		else if sp41b=2 then dn4_cold_pain=0;

	if sp41c=1 then dn4_electric_shocks=1;
		else if sp41c=2 then dn4_electric_shocks=0;

	if sp42a=1 then dn4_tingling=1;
		else if sp42a=2 then dn4_tingling=0;

	if sp42b=1 then dn4_pins_needles=1;
		else if sp42b=2 then dn4_pins_needles=0;

	if sp42c=1 then dn4_numb=1;
		else if sp42c=2 then dn4_numb=0;

	if sp42d=1 then dn4_itching=1;
		else if sp42d=2 then dn4_itching=0;

run;

/* Add total mnsi and dn4 */
data studypop6_;
	set studypop6;

	mnsi_sum=sum(mnsi1, mnsi2, mnsi3, mnsi5, mnsi6, mnsi7, mnsi8, mnsi9, mnsi11, mnsi12, mnsi13, mnsi14, mnsi15);
	mnsi_answered=sum(^missing(mnsi1), ^missing(mnsi2), ^missing(mnsi3), ^missing(mnsi5), ^missing(mnsi6), ^missing(mnsi7), ^missing(mnsi8), ^missing(mnsi9), ^missing(mnsi11), ^missing(mnsi12), ^missing(mnsi13), ^missing(mnsi14), ^missing(mnsi15));

	dn4_sum=sum(dn4_burning, dn4_cold_pain, dn4_electric_shocks, dn4_tingling, dn4_pins_needles, dn4_numb, dn4_itching);
	dn4_answered=sum(^missing(dn4_burning), ^missing(dn4_cold_pain), ^missing(dn4_electric_shocks), ^missing(dn4_tingling), ^missing(dn4_pins_needles), ^missing(dn4_numb), ^missing(dn4_itching));

	if substr(cpr,10,1) in (0,2,4,6,8) then Gender='F';
	if substr(cpr,10,1) in (1,3,5,7,9) then Gender='M';
	adrdato = '24MAY16'd; 

run;


data data.studypop6_format;
	set studypop6_; /* small change in file */

format 
smoke												smoke.
alcohol											alcohol.	
physical_act_days						physical_act_days.	
physical_act_regular				physical_act_regular.	
physical_act_lastyear				physical_act_lastyear.	
walk_unstable								walk_unstable.	
fall_year										fall_year.	
fall_how_often							fall_how_often.	
fall_doctor									fall_doctor.	
fall_hospital								fall_hospital.	
qol													qol.	
sleep1											sleep1_.
sleep2											sleep2_.	
sleep3											sleep3_.
sleep4											sleep4_.	
anxiety1										anxiety1_.	
anxiety2										anxiety2_.	
anxiety3										anxiety3_.
anxiety4										anxiety4_.
depr1												depr1_.
depr2												depr2_.
depr3												depr3_.
depr4												depr4_.
mnsi1												mnsi1_.
mnsi2												mnsi2_.	
mnsi3												mnsi3_.
x_mnsi4											x_mnsi4_.
mnsi5												mnsi5_.
mnsi6												mnsi6_.
mnsi7												mnsi7_.	
mnsi8												mnsi8_.
mnsi9												mnsi9_.
x_mnsi10										x_mnsi10_.
mnsi11											mnsi11_.
mnsi12											mnsi12_.
mnsi13											mnsi13_.
mnsi14											mnsi14_.	
mnsi15											mnsi15_.
pain												pain.
pain_head										pain_head.
pain_back										pain_back.
pain_shoulder								pain_shoulder.
pain_hands									pain_hands.
pain_stomach								pain_stomach.
pain_legs										pain_legs.
pain_other									pain_other.
pain_feet										pain_feet.
pain_bothfeet								pain_bothfeet.
pain_legs										pain_legs.
pain_hands									pain_hands.
pain_feet_night							pain_feet_night.
pain_feet_dur								pain_feet_dur.
pain_feet_24h								pain_feet_24h.
pain_feet_7d								pain_feet_7d.
pain_med										pain_med.
prescription_no							prescription_no.
prescription								prescription.
pain_interference1					pain_interference1_.	
pain_interference2					pain_interference2_.
pain_interference3					pain_interference3_.
pain_interference4					pain_interference4_.
dn4_burning									dn4_burning.
dn4_cold_pain								dn4_cold_pain.
dn4_electric_shocks					dn4_electric_shocks.
dn4_tingling								dn4_tingling.
dn4_pins_needles						dn4_pins_needles.
dn4_numb										dn4_numb.
dn4_itching									dn4_itching.
;
run;

