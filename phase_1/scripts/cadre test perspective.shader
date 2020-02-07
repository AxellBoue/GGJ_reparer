shader_type canvas_item;

uniform float height = 1080.0;
uniform float perspAmount : hint_range(0,10) = 10;

void vertex(){
	float deformation = -(VERTEX.y )/height;
	//VERTEX.x = VERTEX.x - VERTEX.y/2.0;
	//VERTEX.x = (10.0-perspAmount)/10.0 * VERTEX.x;
	VERTEX.x = VERTEX.x - (perspAmount)/10.0 * VERTEX.x * deformation;
	//VERTEX.y = perspAmount/10.0 * VERTEX.y;
	}