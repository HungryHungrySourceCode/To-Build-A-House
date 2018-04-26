// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Specular PBS" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
		}

		Fog {
			Mode Global
			Density 0
			Color (1, 1, 1, 1) 
			Range 0, 300
		}

		Stencil {
			Ref 0
			Comp Always
			Pass Keep
			Fail Keep
			ZFail Keep
		}

		Cull Off
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf StandardSpecular vertex:vert addshadow fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Texture;
		float3 _p0_pi0_nc0_o1;
		float _p0_pi0_nc2_o0;
		float3 _p0_pi0_nc7_o1;
		float3 _p0_pi0_nc8_o4;
		float3 _p0_pi0_nc10_o2;

		struct appdata{
			float4 vertex    : POSITION;  // The vertex position in model space.
			float3 normal    : NORMAL;    // The vertex normal in model space.
			float4 texcoord  : TEXCOORD0; // The first UV coordinate.
			float4 texcoord1 : TEXCOORD1; // The second UV coordinate.
			float4 texcoord2 : TEXCOORD2; // The third UV coordinate.
			float4 tangent   : TANGENT;   // The tangent vector in Model Space (used for normal mapping).
			float4 color     : COLOR;     // Per-vertex color.
		};

		struct Input{
			float2 texcoord : TEXCOORD0;
			float2 texcoord1 : TEXCOORD1;
			float2 uv_Texture;
			float4 position;

			INTERNAL_DATA
		};

		void vert (inout appdata v, out Input IN){
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN.position = UnityObjectToClipPos(v.vertex);
		}

		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			_p0_pi0_nc0_o1 = float4(0.3600896, 0.07082614, 0.9632353, 1).rgb;
			_p0_pi0_nc2_o0 = 1;
			_p0_pi0_nc7_o1 = float4(0.7426471, 0.2566501, 0.2566501, 1).rgb;
			_p0_pi0_nc8_o4 = tex2D(_Texture, IN.uv_Texture).rgb;
			_p0_pi0_nc10_o2 = (_p0_pi0_nc8_o4 + _p0_pi0_nc0_o1);
			o.Albedo = _p0_pi0_nc10_o2;
			o.Specular = _p0_pi0_nc7_o1;
			o.Smoothness = _p0_pi0_nc2_o0;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
