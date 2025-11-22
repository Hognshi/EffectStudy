// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/19Week/FX_Projectile_Trail"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Main_UPanner("Main_UPanner", Float) = 0
		_Base_UPAnner("Base_UPAnner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Base_VPanner("Base_VPanner", Float) = 0
		_BaseTex("BaseTex", 2D) = "white" {}
		_MainPower("MainPower", Float) = 4.42
		_MainIns("MainIns", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _BaseTex;
		uniform float _Base_UPAnner;
		uniform float _Base_VPanner;
		uniform float4 _BaseTex_ST;
		uniform sampler2D _MainTex;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _MainTex_ST;
		uniform float _MainPower;
		uniform float _MainIns;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult12 = (float2(_Base_UPAnner , _Base_VPanner));
			float2 uv0_BaseTex = i.uv_texcoord * _BaseTex_ST.xy + _BaseTex_ST.zw;
			float2 panner10 = ( 1.0 * _Time.y * appendResult12 + uv0_BaseTex);
			float2 appendResult6 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner2 = ( 1.0 * _Time.y * appendResult6 + uv0_MainTex);
			float4 tex2DNode1 = tex2D( _MainTex, panner2 );
			float temp_output_18_0 = ( pow( saturate( ( ( tex2D( _BaseTex, panner10 ).r + tex2DNode1.r ) * tex2DNode1.r ) ) , _MainPower ) * _MainIns );
			o.Emission = ( temp_output_18_0 * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( temp_output_18_0 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1000;1300;1830;1193;567.1202;782.5367;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-1638.509,-548.2086;Float;False;Property;_Base_UPAnner;Base_UPAnner;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1638.509,-433.8087;Float;False;Property;_Base_VPanner;Base_VPanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1565.57,-105.8688;Float;False;Property;_Main_UPanner;Main_UPanner;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1565.57,8.531113;Float;False;Property;_Main_VPanner;Main_VPanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1408.41,-511.8087;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1618.873,-254.369;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1691.812,-697.7086;Float;False;0;7;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;6;-1335.471,-69.46894;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;10;-1244.609,-537.8088;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;2;-1171.67,-95.46902;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-967.1,-324.4003;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;fe63c65849ece4943891bf77b393816b;fe63c65849ece4943891bf77b393816b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-973.1701,-586.1683;Float;True;Property;_BaseTex;BaseTex;6;0;Create;True;0;0;False;0;6d73835c8b264db41a2e294a9354c4f0;6d73835c8b264db41a2e294a9354c4f0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-476.181,-450.122;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-231.181,-323.122;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;15;19.45288,-323.5602;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;75.45288,-432.5602;Float;False;Property;_MainPower;MainPower;7;0;Create;True;0;0;False;0;4.42;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;241.4529,-311.5602;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;425.4529,-433.5602;Float;False;Property;_MainIns;MainIns;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;571.4529,-310.5602;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;1040.95,28.89326;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;21;1016.801,-162.0002;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;1242.553,-339.6602;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1330.85,54.89262;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1490.8,-384.7001;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/19Week/FX_Projectile_Trail;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;8;0
WireConnection;12;1;9;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;10;0;11;0
WireConnection;10;2;12;0
WireConnection;2;0;3;0
WireConnection;2;2;6;0
WireConnection;1;1;2;0
WireConnection;7;1;10;0
WireConnection;13;0;7;1
WireConnection;13;1;1;1
WireConnection;14;0;13;0
WireConnection;14;1;1;1
WireConnection;15;0;14;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;18;0;16;0
WireConnection;18;1;19;0
WireConnection;22;0;18;0
WireConnection;20;0;18;0
WireConnection;20;1;21;0
WireConnection;23;0;21;4
WireConnection;23;1;22;0
WireConnection;0;2;20;0
WireConnection;0;9;23;0
ASEEND*/
//CHKSM=853D2A4A42461D9E24349B39278B3A79F876FE49