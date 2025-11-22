// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HomwWork/Projectile/Helix/Add"
{
	Properties
	{
		_BaseTex("BaseTex", 2D) = "white" {}
		_GradationTex("GradationTex", 2D) = "white" {}
		_MainPower("MainPower", Float) = 1
		_ColorPower("ColorPower", Float) = 1
		_MainIns("MainIns", Float) = 1
		_BaseUPanner("BaseUPanner", Float) = 0
		_ColorIns("ColorIns", Float) = 1
		_BaseVpanner("BaseVpanner", Float) = 0
		_MainUPanner("MainUPanner", Float) = 0
		_MainVpanner("MainVpanner", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
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

		uniform sampler2D _GradationTex;
		uniform float4 _GradationTex_ST;
		uniform float _ColorPower;
		uniform float _ColorIns;
		uniform sampler2D _BaseTex;
		uniform float _BaseUPanner;
		uniform float _BaseVpanner;
		uniform sampler2D _MainTex;
		uniform float _MainUPanner;
		uniform float _MainVpanner;
		uniform float _MainPower;
		uniform float _MainIns;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color25 = IsGammaSpace() ? float4(0.2745098,0.1058824,0.282353,1) : float4(0.06124606,0.0109601,0.06480331,1);
			float4 color28 = IsGammaSpace() ? float4(0,0,0,1) : float4(0,0,0,1);
			float2 uv_GradationTex = i.uv_texcoord * _GradationTex_ST.xy + _GradationTex_ST.zw;
			float4 lerpResult29 = lerp( color25 , color28 , saturate( ( saturate( pow( tex2D( _GradationTex, uv_GradationTex ).r , _ColorPower ) ) * _ColorIns ) ));
			float2 appendResult11 = (float2(_BaseUPanner , _BaseVpanner));
			float2 panner12 = ( 1.0 * _Time.y * appendResult11 + i.uv_texcoord);
			float2 appendResult19 = (float2(_MainUPanner , _MainVpanner));
			float2 panner18 = ( 1.0 * _Time.y * appendResult19 + i.uv_texcoord);
			float4 tex2DNode14 = tex2D( _MainTex, panner18 );
			float temp_output_5_0 = ( pow( saturate( ( ( tex2D( _BaseTex, panner12 ).r + tex2DNode14.r ) * tex2DNode14.r ) ) , _MainPower ) * _MainIns );
			o.Emission = ( ( lerpResult29 * i.vertexColor ) * temp_output_5_0 ).rgb;
			o.Alpha = ( temp_output_5_0 * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
724;789;1830;1154;2885.912;-425.5351;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;17;-2166.177,650.9433;Float;False;Property;_MainVpanner;MainVpanner;10;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-2171.688,139.5875;Float;False;Property;_BaseUPanner;BaseUPanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2168.688,244.5876;Float;False;Property;_BaseVpanner;BaseVpanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-2169.177,545.9433;Float;False;Property;_MainUPanner;MainUPanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-2119.177,364.9433;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;19;-1903.177,517.9434;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;11;-1905.686,111.5875;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-2121.688,-41.41252;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-1697.103,-533.6865;Float;False;Property;_ColorPower;ColorPower;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-1833.604,-291.8861;Float;True;Property;_GradationTex;GradationTex;2;0;Create;True;0;0;False;0;0964f63808cad004dafaaf75fe572bbd;0964f63808cad004dafaaf75fe572bbd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;18;-1723.177,443.9433;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;12;-1725.686,37.58743;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;14;-1411.228,410.9526;Float;True;Property;_MainTex;MainTex;11;0;Create;True;0;0;False;0;562022903ef735a4bb66a8c890c3f498;562022903ef735a4bb66a8c890c3f498;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1415.485,11.82304;Float;True;Property;_BaseTex;BaseTex;1;0;Create;True;0;0;False;0;a537906a8bc50cd4198ad46a68d8a422;a537906a8bc50cd4198ad46a68d8a422;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;32;-1525.504,-286.6868;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1360.404,-529.7866;Float;False;Property;_ColorIns;ColorIns;7;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;34;-1259.004,-287.9868;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-938.3006,235.6117;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-791.2731,306.1814;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1057.504,-287.9868;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;21;-633.2731,307.1814;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-666.0551,157.3304;Float;False;Property;_MainPower;MainPower;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;-476.6894,-155.5152;Float;False;Constant;_Color1;Color 1;9;0;Create;True;0;0;False;0;0,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;-477.8373,-345.3174;Float;False;Constant;_Color0;Color 0;9;0;Create;True;0;0;False;0;0.2745098,0.1058824,0.282353,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;36;-818.3034,-286.6865;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;4;-417.0551,305.3304;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;23;-196.5893,96.47994;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-411.0551,156.3304;Float;False;Property;_MainIns;MainIns;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;-129.5893,-243.9152;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;116.6368,-99.68918;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-231.0551,304.3304;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;110.9015,514.5257;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;97.18774,243.3684;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;367.3674,61.42294;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;HomwWork/Projectile/Helix/Add;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;16;0
WireConnection;19;1;17;0
WireConnection;11;0;7;0
WireConnection;11;1;8;0
WireConnection;18;0;15;0
WireConnection;18;2;19;0
WireConnection;12;0;6;0
WireConnection;12;2;11;0
WireConnection;14;1;18;0
WireConnection;1;1;12;0
WireConnection;32;0;30;1
WireConnection;32;1;31;0
WireConnection;34;0;32;0
WireConnection;13;0;1;1
WireConnection;13;1;14;1
WireConnection;20;0;13;0
WireConnection;20;1;14;1
WireConnection;35;0;34;0
WireConnection;35;1;33;0
WireConnection;21;0;20;0
WireConnection;36;0;35;0
WireConnection;4;0;21;0
WireConnection;4;1;2;0
WireConnection;29;0;25;0
WireConnection;29;1;28;0
WireConnection;29;2;36;0
WireConnection;26;0;29;0
WireConnection;26;1;23;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;27;0;5;0
WireConnection;27;1;23;4
WireConnection;24;0;26;0
WireConnection;24;1;5;0
WireConnection;0;2;24;0
WireConnection;0;9;27;0
ASEEND*/
//CHKSM=E842915000E987196D449C7F1B80CA066C6810B9