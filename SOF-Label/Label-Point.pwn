new ArtytydMove[2];
 	
ArtytydMoveObj()
{
	ArtytydMove[0] = CreateDynamicObject(2716, 1705.569335, -2263.124511, 13.726696, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(ArtytydMove[0], 0, "JANGAN RUSUH", 140, "Calibri", 95, 1, 0xEF80FFFF, 0x00000000, 1);
	ArtytydMove[1] = CreateDynamicObject(2716, 1704.729614, -2263.124511, 13.726696, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(ArtytydMove[1], 0, "DAN CJ", 140, "Calibri", 95, 1, 0xEF80FFFF, 0x00000000, 1);
}
	
forward RulesMove();
public RulesMove()
{
   	new var = random(2);
   	switch (var)
   	{
   		case 0:
   		{
			MoveDynamicObject(ArtytydMove[0], 1705.569335, -2263.124511, 13.726696, 0.2);
        	MoveDynamicObject(ArtytydMove[1], 1704.729614, -2263.124511, 13.726696, 0.2);
		}
   		case 1:
   		{
			MoveDynamicObject(ArtytydMove[0], 1705.569335, -2263.124511, 12.766695, 0.2);
			MoveDynamicObject(ArtytydMove[1], 1704.729614, -2263.124511, 12.766695, 0.2);
		}
	}
}
