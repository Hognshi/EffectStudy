// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/AmplifyShader/17Week/Portal"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", CUBE) = "white" {}
		_Mask_Radious("Mask_Radious", Float) = 4
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldRefl;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform samplerCUBE _TextureSample0;
		uniform float _Mask_Radious;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldReflection = i.worldRefl;
			o.Emission = texCUBE( _TextureSample0, ase_worldReflection ).rgb;
			float2 temp_cast_1 = (0.5).xx;
			float temp_output_8_0 = length( ( i.uv_texcoord - temp_cast_1 ) );
			o.Alpha = step( pow( temp_output_8_0 , _Mask_Radious ) , 0.1 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
617;235;1830;1217;1756.861;-310.9196;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;7;-1759.61,381.98;Float;False;634.6013;353.2998;중간으로 옮기기 위해 -0.5;3;5;6;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1488.609,613.9795;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1709.61,433.2798;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;5;-1291.008,431.98;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;8;-1077.808,430.6801;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;3;-1194,-80.5;Float;False;266;233;큐브를 3D로 펼쳐줌;1;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;13;-624.0993,382.4891;Float;False;227;185;거듭제곱;1;11;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-763.8992,278.7893;Float;False;Property;_Mask_Radious;Mask_Radious;1;0;Create;True;0;0;False;0;4;6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;10;-876.299,382.4893;Float;False;229;161;반전시키는 노드;1;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldReflectionVector;2;-1144,-30.5;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;11;-574.0994,432.4891;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-503.3998,269.389;Float;False;Constant;_Float2;Float 2;1;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;9;-825.299,432.4893;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-769,-58.5;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;4cbe10dc8dcd14b529a78b13c3684fb3;4cbe10dc8dcd14b529a78b13c3684fb3;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;14;-301.0998,433.789;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;249.5163,-130.6062;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/AmplifyShader/17Week/Portal;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;8;0;5;0
WireConnection;11;0;8;0
WireConnection;11;1;12;0
WireConnection;9;0;8;0
WireConnection;1;1;2;0
WireConnection;14;0;11;0
WireConnection;14;1;15;0
WireConnection;0;2;1;0
WireConnection;0;9;14;0
ASEEND*/
//CHKSM=24C64FE7C848CDD5DB0154E9BB6DAE2DA61C1900