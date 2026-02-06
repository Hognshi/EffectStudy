// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/27week/FX_Boom"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Emi_Power("Emi_Power", Float) = 1
		_Emi_Ins("Emi_Ins", Float) = 1
		_Emi_Glow("Emi_Glow", Float) = 1
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_Noise_Upaaner("Noise_Upaaner", Float) = 0
		_Noise_Vpaaner("Noise_Vpaaner", Float) = 0
		_NormalTex("NormalTex", 2D) = "bump" {}
		_Normal_Upanner("Normal_Upanner", Float) = 0
		_Normal_Vpanner("Normal_Vpanner", Float) = 0
		_Distortion("Distortion", Float) = 0
		_DissolveTex("DissolveTex", 2D) = "white" {}
		_Dissolve_Upanner("Dissolve_Upanner", Float) = 0
		_Dissolve_Vpanner("Dissolve_Vpanner", Float) = 0
		_Opacity("Opacity", Float) = 0
		[HideInInspector] _tex4coord4( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv4_tex4coord4;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _NoiseTex;
		uniform float _Noise_Upaaner;
		uniform float _Noise_Vpaaner;
		uniform float4 _NoiseTex_ST;
		uniform sampler2D _MainTex;
		uniform sampler2D _NormalTex;
		uniform float _Normal_Upanner;
		uniform float _Normal_Vpanner;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float _Emi_Power;
		uniform float _Emi_Ins;
		uniform float _Emi_Glow;
		uniform sampler2D _DissolveTex;
		uniform float _Dissolve_Upanner;
		uniform float _Dissolve_Vpanner;
		uniform float4 _DissolveTex_ST;
		uniform float4 _MainTex_ST;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 appendResult13 = (float4(i.uv4_tex4coord4.x , i.uv4_tex4coord4.y , i.uv4_tex4coord4.z , i.uv4_tex4coord4.w));
			float2 appendResult40 = (float2(_Noise_Upaaner , _Noise_Vpaaner));
			float2 uv0_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			float2 panner39 = ( 1.0 * _Time.y * appendResult40 + uv0_NoiseTex);
			float2 appendResult25 = (float2(_Normal_Upanner , _Normal_Vpanner));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 appendResult62 = (float2(( i.uv2_tex4coord2.z + uv0_NormalTex.x ) , uv0_NormalTex.y));
			float2 panner24 = ( 1.0 * _Time.y * appendResult25 + appendResult62);
			float2 appendResult45 = (float2(( -0.02 + i.uv_texcoord.x ) , i.uv_texcoord.y));
			o.Emission = ( ( appendResult13 * ( saturate( ( tex2D( _NoiseTex, panner39 ).r + i.uv2_tex4coord2.x ) ) * ( ( pow( tex2D( _MainTex, ( ( (UnpackNormal( tex2D( _NormalTex, panner24 ) )).xy * _Distortion ) + i.uv_texcoord ) ).r , _Emi_Power ) * _Emi_Ins ) + ( tex2D( _MainTex, appendResult45 ).b * _Emi_Glow ) ) ) ) + i.vertexColor ).xyz;
			float2 appendResult57 = (float2(_Dissolve_Upanner , _Dissolve_Vpanner));
			float2 uv0_DissolveTex = i.uv_texcoord * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
			float2 appendResult64 = (float2(( i.uv2_tex4coord2.w + uv0_DissolveTex.x ) , uv0_DissolveTex.y));
			float2 panner58 = ( 1.0 * _Time.y * appendResult57 + appendResult64);
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( saturate( ( tex2D( _DissolveTex, panner58 ).r + i.uv2_tex4coord2.y ) ) * tex2D( _MainTex, uv_MainTex ).g * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;2841.536;1370.174;2.772827;False;False
Node;AmplifyShaderEditor.CommentaryNode;68;-2113.815,-1337.394;Float;False;1811.031;985.3457;Comment;14;27;26;25;24;21;31;22;19;28;20;62;23;61;63;;1,0,0,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;63;-2063.816,-1287.394;Float;True;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-2050.526,-1037.513;Float;False;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-1802.09,-788.4776;Float;False;Property;_Normal_Upanner;Normal_Upanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1803.09,-704.4776;Float;False;Property;_Normal_Vpanner;Normal_Vpanner;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-1754.817,-1123.394;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-1561.09,-783.4776;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;62;-1602.956,-1016.239;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;24;-1412.09,-917.4777;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;-1191.77,-946.6513;Float;True;Property;_NormalTex;NormalTex;8;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;71;-991.294,-27.46426;Float;False;2609.717;888.59;Comment;17;49;50;51;48;52;15;64;66;55;56;57;58;54;59;4;53;67;;0.04370499,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;70;-631.8657,886.0365;Float;False;1314.324;523.3254;Comment;7;44;45;5;33;32;47;46;;0.09125233,0,1,1;0;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;67;-941.294,22.53571;Float;True;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;22;-873.0878,-947.4776;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-836.1204,-660.4176;Float;False;Property;_Distortion;Distortion;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;-898.0186,265.7842;Float;False;0;54;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;69;-144.8484,-1239.684;Float;False;1606.346;734.765;Comment;13;41;42;40;38;39;35;18;36;43;12;37;13;11;;1,0,0,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-769.0739,-511.0484;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;-89.84834,-795.7289;Float;False;Property;_Noise_Vpaaner;Noise_Vpaaner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-94.84834,-884.7289;Float;False;Property;_Noise_Upaaner;Noise_Upaaner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;-632.2941,186.5357;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-517.8655,936.0366;Float;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;False;0;-0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-617.3189,-684.6126;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;-581.8657,1068.037;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;56;-597.6082,414.5136;Float;False;Property;_Dissolve_Upanner;Dissolve_Upanner;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-594.7792,498.0861;Float;False;Property;_Dissolve_Vpanner;Dissolve_Vpanner;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;72;-273.5703,-457.6219;Float;False;1359.404;420.7804;Comment;6;9;6;10;8;34;3;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-354.9896,940.5327;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-454.7837,-535.8108;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;64;-480.4331,293.6905;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;133.1517,-877.7289;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;38;27.39676,-1059.897;Float;False;0;35;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;2;-600.9434,-313.4037;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;083e76ce7cf7dd4468f218294ec0592d;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;-384.8052,422.5991;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;3;-223.5703,-317.6113;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;39;289.424,-904.4634;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;58.05025,-407.6219;Float;False;Property;_Emi_Power;Emi_Power;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-258.8656,1096.037;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;58;-184.7254,293.1908;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;33;211.9029,1293.363;Float;False;Property;_Emi_Glow;Emi_Glow;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-79.80291,1064.364;Float;True;Property;_TextureSample2;Texture Sample 2;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;406.0497,264.7863;Float;True;Property;_DissolveTex;DissolveTex;12;0;Create;True;0;0;False;0;049e9417ce3abb14aaf43efe7d2daaa0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;35;509.1765,-934.5574;Float;True;Property;_NoiseTex;NoiseTex;5;0;Create;True;0;0;False;0;c3ec6f776be501a4db757961359756df;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;18;603.9445,-711.9185;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;6;207.6195,-290.8415;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;446.1312,-194.9984;Float;False;Property;_Emi_Ins;Emi_Ins;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;49;532.5073,488.6304;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;447.4585,1134.463;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;798.8917,511.5247;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;618.9066,-300.6954;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;851.2468,-794.5833;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;850.8337,-299.2971;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-99.61115,567.1068;Float;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;51;949.715,512.6592;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;12;659.5255,-1189.684;Float;True;3;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;53;972.7745,745.1259;Float;False;Property;_Opacity;Opacity;15;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;43;965.3118,-794.1263;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;1105.998,595.1426;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;955.5254,-1167.684;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;1097.15,-679.2908;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;1226.498,-784.479;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;52;1237.774,595.1258;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;14;1180.912,-258.2141;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;1488.591,-285.7947;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;1383.423,571.6588;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1681.944,-334.0213;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/27week/FX_Boom;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;61;0;63;3
WireConnection;61;1;23;1
WireConnection;25;0;26;0
WireConnection;25;1;27;0
WireConnection;62;0;61;0
WireConnection;62;1;23;2
WireConnection;24;0;62;0
WireConnection;24;2;25;0
WireConnection;21;1;24;0
WireConnection;22;0;21;0
WireConnection;66;0;67;4
WireConnection;66;1;59;1
WireConnection;28;0;22;0
WireConnection;28;1;31;0
WireConnection;46;0;47;0
WireConnection;46;1;44;1
WireConnection;20;0;28;0
WireConnection;20;1;19;0
WireConnection;64;0;66;0
WireConnection;64;1;59;2
WireConnection;40;0;41;0
WireConnection;40;1;42;0
WireConnection;57;0;56;0
WireConnection;57;1;55;0
WireConnection;3;0;2;0
WireConnection;3;1;20;0
WireConnection;39;0;38;0
WireConnection;39;2;40;0
WireConnection;45;0;46;0
WireConnection;45;1;44;2
WireConnection;58;0;64;0
WireConnection;58;2;57;0
WireConnection;5;0;2;0
WireConnection;5;1;45;0
WireConnection;54;1;58;0
WireConnection;35;1;39;0
WireConnection;6;0;3;1
WireConnection;6;1;9;0
WireConnection;32;0;5;3
WireConnection;32;1;33;0
WireConnection;50;0;54;1
WireConnection;50;1;49;2
WireConnection;8;0;6;0
WireConnection;8;1;10;0
WireConnection;36;0;35;1
WireConnection;36;1;18;1
WireConnection;34;0;8;0
WireConnection;34;1;32;0
WireConnection;4;0;2;0
WireConnection;51;0;50;0
WireConnection;43;0;36;0
WireConnection;48;0;51;0
WireConnection;48;1;4;2
WireConnection;48;2;53;0
WireConnection;13;0;12;1
WireConnection;13;1;12;2
WireConnection;13;2;12;3
WireConnection;13;3;12;4
WireConnection;37;0;43;0
WireConnection;37;1;34;0
WireConnection;11;0;13;0
WireConnection;11;1;37;0
WireConnection;52;0;48;0
WireConnection;16;0;11;0
WireConnection;16;1;14;0
WireConnection;15;0;14;4
WireConnection;15;1;52;0
WireConnection;0;2;16;0
WireConnection;0;9;15;0
ASEEND*/
//CHKSM=BC8306030A4E7AFCAA137A78A2CE53EC9E610CA8