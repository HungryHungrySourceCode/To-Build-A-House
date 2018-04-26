Shader "Hidden/uSE/Cache/p3c2" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Tessellation config)]
		_Displacement_("Displacement", float) = 0.02
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
		[Header (Colors)]_Outlinetint("Outline tint", Color) = (0.02205884,0.02205884,0.02205884,1)
		_Color("Color", Color) = (0.7573529,0.7573529,0.7573529,1)
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry+10"
			"RenderType" = "Opaque"
		}

		Cull Back
		ZWrite  Off
		Lighting   Off
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf BlinnPhong 
		#include "UnityCG.cginc"
		#pragma target 5.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Texture;
		float4 _Outlinetint;
		float4 _Color;
		float _Displacement_;
		uniform float4 _DispMap_ST;
		float3 _p1_pi0_nc1_o1;

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

		void surf (Input IN, inout SurfaceOutput o) {
			_p1_pi0_nc1_o1 = _Outlinetint.rgb;
			o.Albedo = (_p1_pi0_nc1_o1).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
