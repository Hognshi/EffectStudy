// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/25week/FX_Water_Vertex"
{
	Properties
	{
		[HDR]_Color_High("Color_High", Color) = (1,1,1,0)
		_Color_A("Color_A", Color) = (0,0.5683525,1,0)
		[HDR]_Color_B("Color_B", Color) = (0.6367924,0.8834738,1,0)
		_HighlightTex("HighlightTex", 2D) = "white" {}
		_Highlight_Range("Highlight_Range", Range( 0.01 , 0.9)) = 0.2476907
		_Highlight_Upanner("Highlight_Upanner", Float) = 0
		_Highlight_Vpanner("Highlight_Vpanner", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_Color_Offset("Color_Offset", Float) = 6.13
		_Color_Range("Color_Range", Float) = 75.75
		_Main_Upanner("Main_Upanner", Float) = 0
		_Main_Vpanner("Main_Vpanner", Float) = 0
		_MaskTex("MaskTex", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1 , 1)) = 1
		_Opacity("Opacity", Float) = 1
		_NormalTex("NormalTex", 2D) = "bump" {}
		_Distortion("Distortion", Range( 0 , 1)) = 0
		_Normal_Upanner("Normal_Upanner", Float) = 0
		_Normal_Vpanner("Normal_Vpanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _USE_Custom("USE_Custom", Float) = 0
		_VertexTex("VertexTex", 2D) = "white" {}
		_VertexNormal_Str("VertexNormal_Str", Float) = 0
		_Vertex_Upanner("Vertex_Upanner", Float) = 0
		_Vertex_Vpanner("Vertex_Vpanner", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _MaskTex;
		uniform sampler2D _NormalTex;
		uniform float _Normal_Upanner;
		uniform float _Normal_Vpanner;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float4 _MaskTex_ST;
		uniform sampler2D _VertexTex;
		uniform float _Vertex_Upanner;
		uniform float _Vertex_Vpanner;
		uniform float4 _VertexTex_ST;
		uniform float _VertexNormal_Str;
		uniform float4 _Color_High;
		uniform float _Highlight_Range;
		uniform sampler2D _HighlightTex;
		uniform float _Highlight_Upanner;
		uniform float _Highlight_Vpanner;
		uniform float4 _HighlightTex_ST;
		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform sampler2D _MainTex;
		uniform float _Main_Upanner;
		uniform float _Main_Vpanner;
		uniform float4 _MainTex_ST;
		uniform float _Color_Offset;
		uniform float _Color_Range;
		uniform float _Dissolve;
		uniform float _Opacity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult50 = (float2(_Normal_Upanner , _Normal_Vpanner));
			float2 uv0_NormalTex = v.texcoord.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner49 = ( 1.0 * _Time.y * appendResult50 + uv0_NormalTex);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch55 = v.texcoord1.w;
			#else
				float staticSwitch55 = _Distortion;
			#endif
			float2 temp_output_46_0 = ( (UnpackNormal( tex2Dlod( _NormalTex, float4( panner49, 0, 0.0) ) )).xy * staticSwitch55 );
			float2 uv0_MaskTex = v.texcoord.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
			float4 tex2DNode19 = tex2Dlod( _MaskTex, float4( ( temp_output_46_0 + uv0_MaskTex ), 0, 0.0) );
			float2 appendResult66 = (float2(_Vertex_Upanner , _Vertex_Vpanner));
			float2 uv0_VertexTex = v.texcoord.xy * _VertexTex_ST.xy + _VertexTex_ST.zw;
			float2 panner65 = ( 1.0 * _Time.y * appendResult66 + uv0_VertexTex);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch77 = v.texcoord1.x;
			#else
				float staticSwitch77 = _VertexNormal_Str;
			#endif
			v.vertex.xyz += ( ase_vertexNormal * ( saturate( ( tex2DNode19.r * (0.0 + (( tex2Dlod( _VertexTex, float4( panner65, 0, 0.0) ).r + 0.2 ) - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)) ) ) * staticSwitch77 ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult50 = (float2(_Normal_Upanner , _Normal_Vpanner));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner49 = ( 1.0 * _Time.y * appendResult50 + uv0_NormalTex);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch55 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch55 = _Distortion;
			#endif
			float2 temp_output_46_0 = ( (UnpackNormal( tex2D( _NormalTex, panner49 ) )).xy * staticSwitch55 );
			float2 appendResult23 = (float2(_Highlight_Upanner , _Highlight_Vpanner));
			float2 uv0_HighlightTex = i.uv_texcoord * _HighlightTex_ST.xy + _HighlightTex_ST.zw;
			float2 panner22 = ( 1.0 * _Time.y * appendResult23 + uv0_HighlightTex);
			float2 appendResult28 = (float2(_Main_Upanner , _Main_Vpanner));
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner27 = ( 1.0 * _Time.y * appendResult28 + uv0_MainTex);
			float4 tex2DNode1 = tex2D( _MainTex, ( temp_output_46_0 + panner27 ) );
			float4 lerpResult9 = lerp( _Color_A , _Color_B , saturate( ( saturate( pow( tex2DNode1.r , _Color_Offset ) ) * _Color_Range ) ));
			o.Emission = ( ( ( _Color_High * step( _Highlight_Range , tex2D( _HighlightTex, ( temp_output_46_0 + panner22 ) ).r ) ) + lerpResult9 ) * i.vertexColor ).rgb;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch56 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch56 = _Dissolve;
			#endif
			float2 uv0_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			float4 tex2DNode19 = tex2D( _MaskTex, ( temp_output_46_0 + uv0_MaskTex ) );
			o.Alpha = ( i.vertexColor.a * saturate( ( ( tex2DNode1.r + staticSwitch56 ) * tex2DNode19.r * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;2895.692;941.5245;2.221382;True;False
Node;AmplifyShaderEditor.RangedFloatNode;52;-2560.685,-200.9012;Float;False;Property;_Normal_Vpanner;Normal_Vpanner;19;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-2563.578,-289.1494;Float;False;Property;_Normal_Upanner;Normal_Upanner;18;0;Create;True;0;0;False;0;0;-0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;50;-2330.661,-283.3626;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-2418.909,-426.585;Float;False;0;44;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;49;-2155.61,-341.2303;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2146.184,-180.961;Float;False;Property;_Distortion;Distortion;17;0;Create;True;0;0;False;0;0;0.128;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1947.084,95.64766;Float;False;Property;_Main_Upanner;Main_Upanner;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;57;-2095.922,285.9157;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-1945.652,168.6517;Float;False;Property;_Main_Vpanner;Main_Vpanner;12;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-1948.732,-370.1641;Float;True;Property;_NormalTex;NormalTex;16;0;Create;True;0;0;False;0;645b0a2fda25d114599a2fba6417fe81;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1705.17,91.3533;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;55;-1787.822,-180.7843;Float;False;Property;_USE_Custom;USE_Custom;20;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;45;-1620.335,-368.718;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1792.487,-50.35952;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;27;-1493.315,-47.49686;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1400.438,-322.4234;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-1943.893,990.2573;Float;False;Property;_Vertex_Vpanner;Vertex_Vpanner;24;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1939.893,903.2571;Float;False;Property;_Vertex_Upanner;Vertex_Upanner;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-1252.526,-74.89937;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1928.089,-559.3459;Float;False;Property;_Highlight_Upanner;Highlight_Upanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1925.188,-478.9981;Float;False;Property;_Highlight_Vpanner;Highlight_Vpanner;7;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;64;-1790.223,742.7454;Float;False;0;58;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;66;-1739.893,915.2571;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;65;-1521.123,770.6454;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-1772.024,-698.0095;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;23;-1684.706,-556.2965;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1094.721,-102.8344;Float;True;Property;_MainTex;MainTex;8;0;Create;True;0;0;False;0;c2f5e06ce5d539b418dc5ebfbfeeee94;c2f5e06ce5d539b418dc5ebfbfeeee94;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-901.8684,156.079;Float;False;Property;_Color_Offset;Color_Offset;9;0;Create;True;0;0;False;0;6.13;2.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;22;-1472.852,-695.1468;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;3;-731.8684,63.07898;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-1164.349,1007.978;Float;False;Constant;_Float0;Float 0;26;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;58;-1288.698,736.7779;Float;True;Property;_VertexTex;VertexTex;21;0;Create;True;0;0;False;0;6e5343f0266cf36489aa21b41e5bc1f7;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-1508.489,553.527;Float;False;0;19;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;74;-925.349,1114.978;Float;False;Constant;_Float1;Float 1;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-979.349,834.9778;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-923.349,1199.978;Float;False;Constant;_Float2;Float 2;26;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-1235.834,533.3179;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-537.8684,159.079;Float;False;Property;_Color_Range;Color_Range;10;0;Create;True;0;0;False;0;75.75;3.17;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;5;-537.8684,64.07898;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1328.232,319.9317;Float;False;Property;_Dissolve;Dissolve;14;0;Create;True;0;0;False;0;1;0.059;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-1225.219,-547.1368;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-840.7999,-577.1002;Float;True;Property;_HighlightTex;HighlightTex;4;0;Create;True;0;0;False;0;c10244bcb5987bd41b64e7758c3af36f;c10244bcb5987bd41b64e7758c3af36f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-354.8684,64.07898;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-632.7634,-703.1321;Float;False;Property;_Highlight_Range;Highlight_Range;5;0;Create;True;0;0;False;0;0.2476907;0.204;0.01;0.9;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;-1032.416,499.2519;Float;True;Property;_MaskTex;MaskTex;13;0;Create;True;0;0;False;0;7f78920f34007b34ca97216413e97960;604a52c360f2090428767147e4f5e133;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;73;-691.7313,911.1815;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;56;-1006.521,318.4156;Float;False;Property;_USE_Custom;USE_Custom;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-411.2802,750.4805;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-41.58339,889.038;Float;False;Property;_VertexNormal_Str;VertexNormal_Str;22;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-311.3525,-129.8506;Float;False;Property;_Color_B;Color_B;3;1;[HDR];Create;True;0;0;False;0;0.6367924,0.8834738,1,0;1.294118,1.780392,2,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;-329.1913,-864.4377;Float;False;Property;_Color_High;Color_High;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;8;-213.8684,65.07898;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;76;-14.84162,1023.862;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-757.3135,301.2258;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;12;-325.4836,-572.729;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-688.1451,630.9667;Float;False;Property;_Opacity;Opacity;15;0;Create;True;0;0;False;0;1;12.41;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-310.0524,-324.8506;Float;False;Property;_Color_A;Color_A;2;0;Create;True;0;0;False;0;0,0.5683525,1,0;0,0.1994608,0.3490566,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-25.35253,-148.0507;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-491.1451,491.9667;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-55.76343,-664.1321;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;70;-231.9576,747.9555;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;77;209.2862,867.3176;Float;False;Property;_USE_Custom;USE_Custom;21;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-28.11012,492.5027;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;18;299.5406,-144.9213;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;59;319.0838,335.6782;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;450.5413,754.2441;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;237.4651,-435.438;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;501.6832,-253.3296;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;602.739,455.1267;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;499.5484,37.97029;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;751.935,-284.0438;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/25week/FX_Water_Vertex;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;50;0;51;0
WireConnection;50;1;52;0
WireConnection;49;0;48;0
WireConnection;49;2;50;0
WireConnection;44;1;49;0
WireConnection;28;0;30;0
WireConnection;28;1;29;0
WireConnection;55;1;47;0
WireConnection;55;0;57;4
WireConnection;45;0;44;0
WireConnection;27;0;26;0
WireConnection;27;2;28;0
WireConnection;46;0;45;0
WireConnection;46;1;55;0
WireConnection;32;0;46;0
WireConnection;32;1;27;0
WireConnection;66;0;67;0
WireConnection;66;1;68;0
WireConnection;65;0;64;0
WireConnection;65;2;66;0
WireConnection;23;0;24;0
WireConnection;23;1;25;0
WireConnection;1;1;32;0
WireConnection;22;0;21;0
WireConnection;22;2;23;0
WireConnection;3;0;1;1
WireConnection;3;1;4;0
WireConnection;58;1;65;0
WireConnection;72;0;58;1
WireConnection;72;1;71;0
WireConnection;53;0;46;0
WireConnection;53;1;54;0
WireConnection;5;0;3;0
WireConnection;31;0;46;0
WireConnection;31;1;22;0
WireConnection;2;1;31;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;19;1;53;0
WireConnection;73;0;72;0
WireConnection;73;3;74;0
WireConnection;73;4;75;0
WireConnection;56;1;34;0
WireConnection;56;0;57;3
WireConnection;69;0;19;1
WireConnection;69;1;73;0
WireConnection;8;0;6;0
WireConnection;33;0;1;1
WireConnection;33;1;56;0
WireConnection;12;0;13;0
WireConnection;12;1;2;1
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;9;2;8;0
WireConnection;42;0;33;0
WireConnection;42;1;19;1
WireConnection;42;2;43;0
WireConnection;14;0;15;0
WireConnection;14;1;12;0
WireConnection;70;0;69;0
WireConnection;77;1;61;0
WireConnection;77;0;76;1
WireConnection;39;0;42;0
WireConnection;60;0;70;0
WireConnection;60;1;77;0
WireConnection;16;0;14;0
WireConnection;16;1;9;0
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;63;0;59;0
WireConnection;63;1;60;0
WireConnection;20;0;18;4
WireConnection;20;1;39;0
WireConnection;0;2;17;0
WireConnection;0;9;20;0
WireConnection;0;11;63;0
ASEEND*/
//CHKSM=AE00B1D0CD40BB6DFFD8839230CCD0EFD3A739C7