// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/30Week/FX_Aura"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_MainPower("MainPower", Float) = 1
		_MainIns("MainIns", Float) = 1
		_MainU("MainU", Float) = 0
		_MainV("MainV", Float) = 0
		_NormalTex("NormalTex", 2D) = "bump" {}
		_NormalU("NormalU", Float) = 0
		_NormalV("NormalV", Float) = 0
		_Distortion("Distortion", Range( 0 , 0.5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Front
		ZWrite Off
		Blend SrcAlpha One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _MainTex;
		uniform sampler2D _NormalTex;
		uniform float _NormalU;
		uniform float _NormalV;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float _MainU;
		uniform float _MainV;
		uniform float4 _MainTex_ST;
		uniform float _MainPower;
		uniform float _MainIns;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult21 = (float2(_NormalU , _NormalV));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult21 + uv0_NormalTex);
			float2 appendResult9 = (float2(_MainU , _MainV));
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner8 = ( 1.0 * _Time.y * appendResult9 + uv0_MainTex);
			o.Emission = ( pow( tex2D( _MainTex, ( ( (UnpackNormal( tex2D( _NormalTex, panner23 ) )).xyz * _Distortion ) + float3( panner8 ,  0.0 ) ).xy ).r , _MainPower ) * _MainIns * i.vertexColor ).rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV12 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode12 = ( 0.0 + 3.0 * pow( 1.0 - fresnelNdotV12, -4.0 ) );
			o.Alpha = ( i.vertexColor.a * saturate( ( 1.0 - fresnelNode12 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
376;1032;1786;1120;2167.827;1193.405;2.229599;True;False
Node;AmplifyShaderEditor.RangedFloatNode;19;-1706.899,-180.0779;Float;False;Property;_NormalU;NormalU;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1704.299,-74.778;Float;False;Property;_NormalV;NormalV;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1570.398,-398.4774;Float;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1506.698,-212.5777;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-1299.998,-368.5774;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-744.9145,154.97;Float;False;Property;_MainU;MainU;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-742.3145,260.27;Float;False;Property;_MainV;MainV;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1071.153,-393.8128;Float;True;Property;_NormalTex;NormalTex;6;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;9;-544.7136,122.4702;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-636.4289,-475.7;Float;False;Property;_Distortion;Distortion;9;0;Create;True;0;0;False;0;0;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;24;-719.5208,-395.0175;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-608.4131,-63.42963;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-446.1618,-384.1793;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;8;-338.0134,-33.52969;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-82.07067,390.2038;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;-4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-85.57067,262.1037;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;12;117.1973,218.5874;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-71.64882,-224.0179;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;261.1973,-229.4126;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;18a3b397c3dac9e439693e60821bdbeb;18a3b397c3dac9e439693e60821bdbeb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;629.1972,-245.4126;Float;False;Property;_MainPower;MainPower;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;389.1972,234.5874;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;693.1973,-165.4126;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;16;613.1972,282.5873;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;6;645.1973,90.58733;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;821.1972,-261.4127;Float;False;Property;_MainIns;MainIns;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;965.1973,-149.4126;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;885.1973,234.5874;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1121.439,-211.2223;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/30Week/FX_Aura;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Front;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;19;0
WireConnection;21;1;20;0
WireConnection;23;0;22;0
WireConnection;23;2;21;0
WireConnection;18;1;23;0
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;24;0;18;0
WireConnection;25;0;24;0
WireConnection;25;1;26;0
WireConnection;8;0;7;0
WireConnection;8;2;9;0
WireConnection;12;2;13;0
WireConnection;12;3;14;0
WireConnection;27;0;25;0
WireConnection;27;1;8;0
WireConnection;1;1;27;0
WireConnection;15;0;12;0
WireConnection;2;0;1;1
WireConnection;2;1;4;0
WireConnection;16;0;15;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;3;2;6;0
WireConnection;17;0;6;4
WireConnection;17;1;16;0
WireConnection;0;2;3;0
WireConnection;0;9;17;0
ASEEND*/
//CHKSM=02BD0699820B8827301EA9B9058C0B0273BCA65F