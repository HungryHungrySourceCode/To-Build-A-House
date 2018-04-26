Shader "Hidden/uSE/Cache/P0C3" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
		_Texture2("Texture2", 2D) = "white" {}
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
		}

		Cull Back
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf Standard addshadow 
		#include "UnityCG.cginc"
		#pragma target 4.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Texture;
		sampler2D _Texture2;
		float2 _p0_pi0_nc0_o0;
		float3 _p0_pi0_nc2_o4;
		float3 _p0_pi0_nc5_o4;
		float3 _p0_pi0_nc7_o2;

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
			float2 uv2_Texture2;
			float4 position;

			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc0_o0 = IN.uv2_Texture2;
			_p0_pi0_nc2_o4 = tex2D(_Texture2, _p0_pi0_nc0_o0).rgb;
			_p0_pi0_nc5_o4 = tex2D(_Texture, IN.uv_Texture).rgb;
			_p0_pi0_nc7_o2 = (_p0_pi0_nc5_o4 + _p0_pi0_nc2_o4);
			o.Albedo = (_p0_pi0_nc7_o2).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
