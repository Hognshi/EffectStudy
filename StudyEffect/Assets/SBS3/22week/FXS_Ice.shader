// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/22week/FX_Ice"
{
	Properties
	{
		_Base_Tex("Base_Tex", 2D) = "white" {}
		_Emi_Tex("Emi_Tex", 2D) = "white" {}
		_Emi_Power("Emi_Power", Float) = 1
		_Emi_Ins("Emi_Ins", Float) = 1
		[HDR]_Emi_Color("Emi_Color", Color) = (1,1,1,0)
		_Desaturate("Desaturate", Range( 0 , 1)) = 0
		_Parallax_Offset("Parallax_Offset", Range( -0.5 , 0.5)) = 0
		_Parallax_Tex("Parallax_Tex", 2D) = "white" {}
		_Parallax_Panner("Parallax_Panner", Vector) = (0,0,0,0)
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (1,1,1,0)
		_Fresnel_Scale("Fresnel_Scale", Float) = 1
		_Fresnel_Power("Fresnel_Power", Float) = 4
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
			float2 uv2_texcoord2;
			float3 viewDir;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _Base_Tex;
		uniform sampler2D _Parallax_Tex;
		uniform float2 _Parallax_Panner;
		uniform float4 _Parallax_Tex_ST;
		uniform float _Parallax_Offset;
		uniform float4 _Base_Tex_ST;
		uniform float _Desaturate;
		uniform sampler2D _Emi_Tex;
		uniform float4 _Emi_Tex_ST;
		uniform float _Emi_Power;
		uniform float _Emi_Ins;
		uniform float4 _Emi_Color;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Power;
		uniform float4 _Fresnel_Color;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv1_Parallax_Tex = i.uv2_texcoord2 * _Parallax_Tex_ST.xy + _Parallax_Tex_ST.zw;
			float2 panner24 = ( 1.0 * _Time.y * _Parallax_Panner + uv1_Parallax_Tex);
			float2 paralaxOffset17 = ParallaxOffset( tex2D( _Parallax_Tex, panner24 ).r , _Parallax_Offset , i.viewDir );
			float2 uv1_Base_Tex = i.uv2_texcoord2 * _Base_Tex_ST.xy + _Base_Tex_ST.zw;
			float3 desaturateInitialColor13 = tex2D( _Base_Tex, ( paralaxOffset17 + uv1_Base_Tex ) ).rgb;
			float desaturateDot13 = dot( desaturateInitialColor13, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar13 = lerp( desaturateInitialColor13, desaturateDot13.xxx, _Desaturate );
			float2 uv_Emi_Tex = i.uv_texcoord * _Emi_Tex_ST.xy + _Emi_Tex_ST.zw;
			float3 temp_cast_1 = (_Emi_Power).xxx;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV26 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode26 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV26, _Fresnel_Power ) );
			o.Emission = ( ( float4( ( pow( ( desaturateVar13 * tex2D( _Emi_Tex, uv_Emi_Tex ).r ) , temp_cast_1 ) * _Emi_Ins ) , 0.0 ) * _Emi_Color ) + ( saturate( fresnelNode26 ) * _Fresnel_Color ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;2201.439;939.3665;2.271632;True;False
Node;AmplifyShaderEditor.Vector2Node;25;-1765.716,-528.5995;Float;False;Property;_Parallax_Panner;Parallax_Panner;11;0;Create;True;0;0;False;0;0,0;0.001,0.001;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-1808.716,-734.5995;Float;False;1;22;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;24;-1541.716,-650.5995;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1285.833,-458.3427;Float;False;Property;_Parallax_Offset;Parallax_Offset;9;0;Create;True;0;0;False;0;0;0.039;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-1303.636,-680.0547;Float;True;Property;_Parallax_Tex;Parallax_Tex;10;0;Create;True;0;0;False;0;a3c943a6914a9f84a8f678a08b3f2e14;a3c943a6914a9f84a8f678a08b3f2e14;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;20;-1209.833,-356.3427;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;17;-948.5483,-480.829;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-944.6628,-277.792;Float;False;1;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-722.8333,-379.3427;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-590.6476,-301.401;Float;True;Property;_Base_Tex;Base_Tex;1;0;Create;True;0;0;False;0;5026617860db53446af7f1e89cb2f0a8;5026617860db53446af7f1e89cb2f0a8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-263.9835,-200.3241;Float;False;Property;_Desaturate;Desaturate;8;0;Create;True;0;0;False;0;0;0.624;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-82.11423,36.52005;Float;True;Property;_Emi_Tex;Emi_Tex;4;0;Create;True;0;0;False;0;d6b59f37abe57454baa18917f10b0029;d6b59f37abe57454baa18917f10b0029;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;13;27.86525,-299.319;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;32;346.0709,746.8563;Float;False;Property;_Fresnel_Power;Fresnel_Power;14;0;Create;True;0;0;False;0;4;12.72;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;349.6898,667.2413;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;13;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;292.0605,148.9122;Float;False;Property;_Emi_Power;Emi_Power;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;327.3243,29.31419;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;26;637.4563,595.3122;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;7;534.2104,127.1004;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;11;761.2108,251.1002;Float;False;Property;_Emi_Ins;Emi_Ins;6;0;Create;True;0;0;False;0;1;0.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;27;912.4894,595.312;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;29;901.485,719.6469;Float;False;Property;_Fresnel_Color;Fresnel_Color;12;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.2830189,0.2830189,0.2830189,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;928.2107,124.1004;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;12;908.2106,308.1003;Float;False;Property;_Emi_Color;Emi_Color;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.5764706,0.6941177,0.7490196,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;1141.211,124.1004;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1158.424,597.8121;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;943.8079,-497.3111;Float;True;Property;_Normal_Tex;Normal_Tex;2;0;Create;True;0;0;False;0;9690c6db67811ad48b0d23026932c4f7;84d2fc850df5c4c4d80eb8572e8ced0b;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;30;1355.731,122.0008;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;764.889,-471.3143;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;530.7405,-391.642;Float;False;1;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;716.9452,-40.17935;Float;False;Property;_Normal_Scale;Normal_Scale;3;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1567.384,-307.0141;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/22week/FX_Ice;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;23;0
WireConnection;24;2;25;0
WireConnection;22;1;24;0
WireConnection;17;0;22;1
WireConnection;17;1;19;0
WireConnection;17;2;20;0
WireConnection;18;0;17;0
WireConnection;18;1;4;0
WireConnection;1;1;18;0
WireConnection;13;0;1;0
WireConnection;13;1;14;0
WireConnection;15;0;13;0
WireConnection;15;1;6;1
WireConnection;26;2;31;0
WireConnection;26;3;32;0
WireConnection;7;0;15;0
WireConnection;7;1;10;0
WireConnection;27;0;26;0
WireConnection;8;0;7;0
WireConnection;8;1;11;0
WireConnection;9;0;8;0
WireConnection;9;1;12;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;2;1;21;0
WireConnection;2;5;3;0
WireConnection;30;0;9;0
WireConnection;30;1;28;0
WireConnection;21;0;17;0
WireConnection;21;1;5;0
WireConnection;0;2;30;0
ASEEND*/
//CHKSM=3AF703F5A61A8BFB0DEBCA3D8831A2157A966C2D