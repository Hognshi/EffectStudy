// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/9/FX_Default_Addictive"
{
	Properties
	{
		[HDR]_MainColor("MainColor", Color) = (1,1,1,0)
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_MainPower("MainPower", Float) = 1
		_MainIns("MainIns", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _MainColor;
		uniform sampler2D _Main_Tex;
		uniform float4 _Main_Tex_ST;
		uniform float _MainPower;
		uniform float _MainIns;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float4 temp_cast_0 = (_MainPower).xxxx;
			o.Emission = ( ( _MainColor * ( pow( tex2D( _Main_Tex, uv0_Main_Tex ) , temp_cast_0 ) * _MainIns ) ) * i.vertexColor ).rgb;
			float temp_output_36_0 = ( i.vertexColor.a * saturate( 0.0 ) );
			o.Alpha = temp_output_36_0;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
771;1213;1830;1175;95.68164;515.9586;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;11;-608.229,-149.8034;Float;False;292;209;U좌클릭;1;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-558.229,-99.8034;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;18;-273.3215,-202.398;Float;False;370;280;T좌클릭, 흰색 텍스쳐라 RBG아무거나 상관없음;1;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;25;307.9009,-364.2977;Float;False;215;166;1좌클릭;1;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;10;158.0711,-173.901;Float;False;310;304;거듭제곱, E좌클릭;1;8;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-97.08346,63.22837;Float;False;Property;_MainPower;MainPower;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-223.3215,-127.7519;Float;True;Property;_Main_Tex;Main_Tex;1;0;Create;True;0;0;False;0;5b57869c547fc434c9bbb8631721af04;8956bdff4724d574fa52c5832f217678;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;357.9012,-314.2977;Float;False;Property;_MainIns;MainIns;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;208.0711,-123.901;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;31;566.0527,-388.2309;Float;False;283;262;머티리얼에서 자체적으로 인텐시티를 조정하기 위함;1;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;622.215,-123.4774;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;35;797.4078,115.6096;Float;False;215;161;0-1값만 존재하게 해줌;1;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;30;616.0527,-338.2309;Float;False;Property;_MainColor;MainColor;0;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;27;865.2552,-70.87301;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;34;847.4079,165.6097;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;956.5419,-333.9574;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1150.071,-121.4456;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;32;558.6257,166.3597;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;37;1205.702,24.00456;Float;False;Property;_UseDepthFade;UseDepthFade;4;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;354.7072,163.3097;Float;False;Property;_DepthFade;DepthFade;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;1072.871,141.3333;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1523.951,-170.6365;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/9/FX_Default_Addictive;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;6;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;1;6;0
WireConnection;8;0;5;0
WireConnection;8;1;9;0
WireConnection;26;0;8;0
WireConnection;26;1;24;0
WireConnection;29;0;30;0
WireConnection;29;1;26;0
WireConnection;28;0;29;0
WireConnection;28;1;27;0
WireConnection;32;0;33;0
WireConnection;37;1;27;4
WireConnection;37;0;36;0
WireConnection;36;0;27;4
WireConnection;36;1;34;0
WireConnection;0;2;28;0
WireConnection;0;9;36;0
ASEEND*/
//CHKSM=D79E339B4E82F025D1F3A111C35AC51A4B97F190