// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Trail"
{
	Properties
	{
		_FXT_ColorGradient("FXT_ColorGradient", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_Main_UPanner("Main_UPanner", Float) = 0
		_U("U", Float) = 1
		_Base_UPAnner("Base_UPAnner", Float) = 0
		_V("V", Float) = 0
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
		Cull Off
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
		uniform sampler2D _MainTex;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float _MainPower;
		uniform float _MainIns;
		uniform sampler2D _FXT_ColorGradient;
		uniform float _U;
		uniform float _V;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult129 = (float2(_Base_UPAnner , _Base_VPanner));
			float2 panner133 = ( 1.0 * _Time.y * appendResult129 + i.uv_texcoord);
			float2 appendResult132 = (float2(_Main_UPanner , _Main_VPanner));
			float2 panner134 = ( 1.0 * _Time.y * appendResult132 + i.uv_texcoord);
			float4 tex2DNode136 = tex2D( _MainTex, panner134 );
			float2 appendResult76 = (float2(_U , _V));
			float2 panner77 = ( 1.0 * _Time.y * appendResult76 + i.uv_texcoord);
			o.Emission = ( ( pow( saturate( ( ( tex2D( _BaseTex, panner133 ).r + tex2DNode136.r ) * tex2DNode136.r ) ) , _MainPower ) * _MainIns ) * i.vertexColor * tex2D( _FXT_ColorGradient, panner77 ) ).rgb;
			o.Alpha = ( tex2DNode136.r * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
419;642;1498;1161;-466.4877;-494.1506;1.084852;True;False
Node;AmplifyShaderEditor.RangedFloatNode;127;-825.543,1474.163;Float;False;Property;_Main_UPanner;Main_UPanner;3;0;Create;True;0;0;False;0;0;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-898.4821,1031.824;Float;False;Property;_Base_UPAnner;Base_UPAnner;5;0;Create;True;0;0;False;0;0;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;126;-898.4821,1146.224;Float;False;Property;_Base_VPanner;Base_VPanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;-825.543,1588.563;Float;False;Property;_Main_VPanner;Main_VPanner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;132;-595.444,1510.563;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;131;-951.7851,882.3236;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;130;-878.8461,1325.663;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;129;-668.3831,1068.224;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;134;-431.6431,1484.563;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;133;-504.5821,1042.223;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;135;-233.1432,993.864;Float;True;Property;_BaseTex;BaseTex;9;0;Create;True;0;0;False;0;6d73835c8b264db41a2e294a9354c4f0;6d73835c8b264db41a2e294a9354c4f0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;136;-227.0731,1255.632;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;d2c9937768d75504886d4429a985441c;fe63c65849ece4943891bf77b393816b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;137;263.8459,1129.91;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;1054.111,724.3196;Float;False;Property;_U;U;4;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;138;508.8459,1256.91;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;1055.49,799.9435;Float;False;Property;_V;V;6;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;76;1205.317,730.1211;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;1114.498,568.751;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;139;815.4798,1147.472;Float;False;Property;_MainPower;MainPower;10;0;Create;True;0;0;False;0;4.42;4.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;140;759.4798,1256.472;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;1165.48,1146.472;Float;False;Property;_MainIns;MainIns;11;0;Create;True;0;0;False;0;1;0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;141;981.4798,1268.472;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;77;1407.959,711.6268;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;1311.48,1269.472;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;1635.13,682.7202;Float;True;Property;_FXT_ColorGradient;FXT_ColorGradient;1;0;Create;True;0;0;False;0;9c06787883add984bb790cd9d873211e;9c06787883add984bb790cd9d873211e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;144;1756.828,1418.032;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;2031.82,1437.53;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;1982.58,1240.372;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2293.385,1057.764;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Trail;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;132;0;127;0
WireConnection;132;1;128;0
WireConnection;129;0;125;0
WireConnection;129;1;126;0
WireConnection;134;0;130;0
WireConnection;134;2;132;0
WireConnection;133;0;131;0
WireConnection;133;2;129;0
WireConnection;135;1;133;0
WireConnection;136;1;134;0
WireConnection;137;0;135;1
WireConnection;137;1;136;1
WireConnection;138;0;137;0
WireConnection;138;1;136;1
WireConnection;76;0;74;0
WireConnection;76;1;75;0
WireConnection;140;0;138;0
WireConnection;141;0;140;0
WireConnection;141;1;139;0
WireConnection;77;0;62;0
WireConnection;77;2;76;0
WireConnection;143;0;141;0
WireConnection;143;1;142;0
WireConnection;9;1;77;0
WireConnection;146;0;136;1
WireConnection;146;1;144;4
WireConnection;145;0;143;0
WireConnection;145;1;144;0
WireConnection;145;2;9;0
WireConnection;0;2;145;0
WireConnection;0;9;146;0
ASEEND*/
//CHKSM=0447113C6AD6BFFD58F062B9398CC512813C8A76