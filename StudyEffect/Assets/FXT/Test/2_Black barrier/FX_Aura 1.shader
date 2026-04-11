// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Aura"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_MainPower("MainPower", Float) = 1
		_MainU("MainU", Float) = 0
		_MainV("MainV", Float) = 0
		_Chroma("Chroma", Range( -0.1 , 0.1)) = -0.01824722
		_MainIns("MainIns", Float) = 1
		_MaskTex("MaskTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _MainTex;
		uniform float _MainU;
		uniform float _MainV;
		uniform float4 _MainTex_ST;
		uniform float _Chroma;
		uniform float _MainPower;
		uniform float _MainIns;
		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult12 = (float2(_MainU , _MainV));
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner7 = ( 1.0 * _Time.y * appendResult12 + uv0_MainTex);
			float2 temp_cast_0 = (_Chroma).xx;
			float3 appendResult11 = (float3(tex2D( _MainTex, ( panner7 + _Chroma ) ).r , tex2D( _MainTex, panner7 ).g , tex2D( _MainTex, ( panner7 - temp_cast_0 ) ).b));
			float3 temp_cast_1 = (_MainPower).xxx;
			o.Emission = ( float4( ( pow( appendResult11 , temp_cast_1 ) * _MainIns ) , 0.0 ) * i.vertexColor ).rgb;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * tex2D( _MaskTex, uv_MaskTex ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
457;503;1786;1096;462.5644;163.4233;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;14;-1612.954,316.7583;Float;False;Property;_MainV;MainV;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1615.954,236.7583;Float;False;Property;_MainU;MainU;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1549.234,5.18473;Float;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1430.954,244.7583;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;7;-1247.634,3.884696;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1245.333,150.7845;Float;False;Property;_Chroma;Chroma;5;0;Create;True;0;0;False;0;-0.01824722;-0.01824722;-0.1;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-939.8323,127.3847;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;4;-1210.15,-261.7419;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;9c273b9163c79834fbae963c69875640;9c273b9163c79834fbae963c69875640;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-943.7324,-96.21528;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;5;-509.0969,-322.3885;Float;True;Property;_TextureSample2;Texture Sample 2;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-502.598,-106.588;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;1660e2c4f161d954fa8674aef3559472;1660e2c4f161d954fa8674aef3559472;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-494.7966,113.1115;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;11;0.2025063,-76.2747;Float;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;17;928.7026,-114.6953;Float;False;Property;_MainPower;MainPower;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;1138.703,-113.6953;Float;False;Property;_MainIns;MainIns;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;15;1007.703,-17.69537;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;21;992.042,353.8406;Float;True;Property;_MaskTex;MaskTex;7;0;Create;True;0;0;False;0;9e4d449a69f83d744ada19a430efa6e3;9e4d449a69f83d744ada19a430efa6e3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;1231.702,-16.69537;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexColorNode;20;1199.803,171.2039;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;23;559.0277,387.4497;Float;False;RadialUVDistortion;-1;;1;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6023;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;1444.655,363.5993;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;1410.703,-16.69537;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;25;288.4356,463.5767;Float;False;Constant;_Vector2;Vector 2;8;0;Create;True;0;0;False;0;0,-1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1618.004,-63.58677;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Aura;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;13;0
WireConnection;12;1;14;0
WireConnection;7;0;6;0
WireConnection;7;2;12;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;8;0;7;0
WireConnection;8;1;10;0
WireConnection;5;0;4;0
WireConnection;5;1;8;0
WireConnection;1;0;4;0
WireConnection;1;1;7;0
WireConnection;2;0;4;0
WireConnection;2;1;9;0
WireConnection;11;0;5;1
WireConnection;11;1;1;2
WireConnection;11;2;2;3
WireConnection;15;0;11;0
WireConnection;15;1;17;0
WireConnection;16;0;15;0
WireConnection;16;1;18;0
WireConnection;23;47;25;0
WireConnection;22;0;20;4
WireConnection;22;1;21;1
WireConnection;19;0;16;0
WireConnection;19;1;20;0
WireConnection;0;2;19;0
WireConnection;0;9;22;0
ASEEND*/
//CHKSM=F79780DBE28DF05BA85FF75C2509EF8BDBFD5C40