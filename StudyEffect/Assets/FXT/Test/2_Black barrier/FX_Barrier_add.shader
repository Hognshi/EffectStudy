// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Test/Black_Barrier"
{
	Properties
	{
		_Main_Pow("Main_Pow", Float) = 1
		_GradationTex("GradationTex", 2D) = "white" {}
		[HDR]_Color_A("Color_A", Color) = (0,0.006187201,1,0)
		_ColorPower("ColorPower", Float) = 1
		[HDR]_Color_B("Color_B", Color) = (0.3503407,0,0.8509804,0)
		_ColorIns("ColorIns", Float) = 1
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
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform sampler2D _GradationTex;
		uniform float4 _GradationTex_ST;
		uniform float _ColorPower;
		uniform float _ColorIns;
		uniform float _Main_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_GradationTex = i.uv_texcoord * _GradationTex_ST.xy + _GradationTex_ST.zw;
			float4 lerpResult20 = lerp( _Color_A , _Color_B , saturate( ( saturate( pow( tex2D( _GradationTex, uv_GradationTex ).r , _ColorPower ) ) * _ColorIns ) ));
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			o.Emission = ( i.vertexColor * ( pow( lerpResult20 , temp_cast_0 ) * 1.0 ) ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
456;666;1786;1084;2679.211;849.4441;1.884465;True;False
Node;AmplifyShaderEditor.RangedFloatNode;11;-1974.111,-42.3485;Float;False;Property;_ColorPower;ColorPower;4;0;Create;True;0;0;False;0;1;1.48;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-1983.67,64.72804;Float;True;Property;_GradationTex;GradationTex;2;0;Create;True;0;0;False;0;0964f63808cad004dafaaf75fe572bbd;0964f63808cad004dafaaf75fe572bbd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;13;-1651.406,92.9785;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;14;-1491.215,92.96391;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1630.083,2.578434;Float;False;Property;_ColorIns;ColorIns;6;0;Create;True;0;0;False;0;1;6.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1284.639,91.62071;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;19;-1125.774,92.64769;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;-1557.891,-189.2979;Float;False;Property;_Color_B;Color_B;5;1;[HDR];Create;True;0;0;False;0;0.3503407,0,0.8509804,0;0.4858491,0.7428545,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;-1560.891,-367.2981;Float;False;Property;_Color_A;Color_A;3;1;[HDR];Create;True;0;0;False;0;0,0.006187201,1,0;0.2843983,0.4720491,0.7830189,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-826.2332,-348.5475;Float;False;Property;_Main_Pow;Main_Pow;1;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;20;-920.677,-197.9324;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;2;-581.9602,-191.7284;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-511.4371,-350.73;Float;False;Constant;_Main_Ins;Main_Ins;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;21;-270.5341,-55.64558;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-354.239,-191.4939;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-85.77976,-211.3349;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;171.9741,-237.5983;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Test/Black_Barrier;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;12;1
WireConnection;13;1;11;0
WireConnection;14;0;13;0
WireConnection;16;0;14;0
WireConnection;16;1;15;0
WireConnection;19;0;16;0
WireConnection;20;0;17;0
WireConnection;20;1;18;0
WireConnection;20;2;19;0
WireConnection;2;0;20;0
WireConnection;2;1;5;0
WireConnection;4;0;2;0
WireConnection;4;1;6;0
WireConnection;8;0;21;0
WireConnection;8;1;4;0
WireConnection;0;2;8;0
WireConnection;0;9;21;4
ASEEND*/
//CHKSM=03236B5C4C902EE577B620C4D985AA8340994A9C