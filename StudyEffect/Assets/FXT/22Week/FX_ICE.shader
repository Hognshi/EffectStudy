// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/22Week/FX_Ice"
{
	Properties
	{
		_BaseTex("BaseTex", 2D) = "white" {}
		_EmiTex("EmiTex", 2D) = "white" {}
		_EmiPower("EmiPower", Float) = 1
		_EmiIns("EmiIns", Float) = 1
		_Desatureate("Desatureate", Range( 0 , 1)) = 0
		[HDR]_EmiColor("EmiColor", Color) = (1,1,1,0)
		_ParallaxOffset("ParallaxOffset", Range( -0.5 , 0.5)) = 0
		_ParallaxTex("ParallaxTex", 2D) = "white" {}
		_ParallaxPanner("ParallaxPanner", Vector) = (0,0,0,0)
		[HDR]_FresnelColor("FresnelColor", Color) = (1,1,1,0)
		_FresnelScale("FresnelScale", Float) = 1
		_FresnelPower("FresnelPower", Float) = 4
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv2_texcoord2;
			float3 viewDir;
			float2 uv_texcoord;
		};

		uniform float _FresnelScale;
		uniform float _FresnelPower;
		uniform float4 _FresnelColor;
		uniform sampler2D _BaseTex;
		uniform sampler2D _ParallaxTex;
		uniform float2 _ParallaxPanner;
		uniform float4 _ParallaxTex_ST;
		uniform float _ParallaxOffset;
		uniform float4 _BaseTex_ST;
		uniform float _Desatureate;
		uniform sampler2D _EmiTex;
		uniform float4 _EmiTex_ST;
		uniform float _EmiPower;
		uniform float _EmiIns;
		uniform float4 _EmiColor;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV30 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode30 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV30, _FresnelPower ) );
			float2 uv1_ParallaxTex = i.uv2_texcoord2 * _ParallaxTex_ST.xy + _ParallaxTex_ST.zw;
			float2 panner27 = ( 1.0 * _Time.y * _ParallaxPanner + uv1_ParallaxTex);
			float2 paralaxOffset21 = ParallaxOffset( tex2D( _ParallaxTex, panner27 ).r , _ParallaxOffset , i.viewDir );
			float2 uv1_BaseTex = i.uv2_texcoord2 * _BaseTex_ST.xy + _BaseTex_ST.zw;
			float3 desaturateInitialColor18 = tex2D( _BaseTex, ( paralaxOffset21 + uv1_BaseTex ) ).rgb;
			float desaturateDot18 = dot( desaturateInitialColor18, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar18 = lerp( desaturateInitialColor18, desaturateDot18.xxx, _Desatureate );
			float2 uv_EmiTex = i.uv_texcoord * _EmiTex_ST.xy + _EmiTex_ST.zw;
			float3 temp_cast_1 = (_EmiPower).xxx;
			o.Emission = ( ( saturate( fresnelNode30 ) * _FresnelColor ) + ( float4( ( pow( ( desaturateVar18 * tex2D( _EmiTex, uv_EmiTex ).r ) , temp_cast_1 ) * _EmiIns ) , 0.0 ) * _EmiColor ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
894;386;1498;1114;749.6112;1230.638;1.6;True;False
Node;AmplifyShaderEditor.Vector2Node;29;-1028.084,-899.3883;Float;False;Property;_ParallaxPanner;ParallaxPanner;11;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1048.084,-1057.388;Float;False;1;26;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;27;-810.0844,-1056.388;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;26;-529.8882,-1083.296;Float;True;Property;_ParallaxTex;ParallaxTex;10;0;Create;True;0;0;False;0;374fa1999bdbe34479e8b8e1bbbb0f04;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;24;-614.9126,-706.2671;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;23;-619.9126,-814.2671;Float;False;Property;_ParallaxOffset;ParallaxOffset;9;0;Create;True;0;0;False;0;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-284.9045,-698.2809;Float;False;1;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;21;-261.5124,-826.0847;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-33.91266,-733.2671;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;174.4137,-675.0563;Float;True;Property;_BaseTex;BaseTex;1;0;Create;True;0;0;False;0;9d96c7e8f310851478a946901b7ee893;9d96c7e8f310851478a946901b7ee893;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;651.8856,-786.4245;Float;False;Property;_Desatureate;Desatureate;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;233.1488,-45.18122;Float;True;Property;_EmiTex;EmiTex;4;0;Create;True;0;0;False;0;99aaac3be239df44cacd26730f3960af;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;18;599.7841,-606.7328;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;573.9778,-295.5837;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;15;562.145,-15.21623;Float;False;Property;_EmiPower;EmiPower;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-563.6814,-49.96777;Float;False;Property;_FresnelPower;FresnelPower;14;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-565.6814,-135.9678;Float;False;Property;_FresnelScale;FresnelScale;13;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;12;676.6454,-152.8162;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;16;759.991,-9.699761;Float;False;Property;_EmiIns;EmiIns;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;30;-387.5952,-218.6605;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;922.9912,30.29993;Float;False;Property;_EmiColor;EmiColor;8;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;881.5454,-154.4159;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;31;-134.3389,-216.5761;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;33;-132.2546,-9.17688;Float;False;Property;_FresnelColor;FresnelColor;12;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;66.8071,-215.5339;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;1093.344,-154.4158;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-421.1649,-495.5439;Float;False;1;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-78.57406,-529.9787;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;1250.206,-198.2034;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;177.1916,-449.6451;Float;True;Property;_NormalTex;NormalTex;2;0;Create;True;0;0;False;0;91fc614fcc4ac464b8df352adb567cbe;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-363.9846,-344.8706;Float;False;Property;_NormalScale;NormalScale;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1385.242,-448.4841;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/22Week/FX_Ice;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;28;0
WireConnection;27;2;29;0
WireConnection;26;1;27;0
WireConnection;21;0;26;1
WireConnection;21;1;23;0
WireConnection;21;2;24;0
WireConnection;22;0;21;0
WireConnection;22;1;9;0
WireConnection;1;1;22;0
WireConnection;18;0;1;0
WireConnection;18;1;19;0
WireConnection;20;0;18;0
WireConnection;20;1;11;1
WireConnection;12;0;20;0
WireConnection;12;1;15;0
WireConnection;30;2;35;0
WireConnection;30;3;36;0
WireConnection;13;0;12;0
WireConnection;13;1;16;0
WireConnection;31;0;30;0
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;14;0;13;0
WireConnection;14;1;17;0
WireConnection;25;0;21;0
WireConnection;25;1;10;0
WireConnection;34;0;32;0
WireConnection;34;1;14;0
WireConnection;2;1;25;0
WireConnection;2;5;3;0
WireConnection;0;2;34;0
ASEEND*/
//CHKSM=291B7A4D03237220EE204A1A1D462BFEBBCD04A1