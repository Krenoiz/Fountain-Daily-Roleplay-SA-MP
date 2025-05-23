enum e_area
{
	STREAMER_TAG_AREA:areaMechanic
};
new AreaData[e_area];


stock LoadArea()
{
    AreaData[areaMechanic] = CreateDynamicSphere(-2360, -116.5, -2312, -80.5);
}