Shader "Hidden/uSE/Cache/p0c12" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Textures and Bumpmaps)]_Heightmap("Height map", 2D) = "white" {}
		_Main("Main", 2D) = "white" {}
		[NoScaleOffset]_Normal("Normal", 2D) = "white" {}
		[NoScaleOffset]_Specular("Specular", 2D) = "white" {}
		[Header (Variables)]_Dispacment("Dispacment", float) = 0.015
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
		}

		Cull Off
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf StandardSpecular addshadow 
		#include "UnityCG.cginc"
		#pragma target 4.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Heightmap;
		sampler2D _Main;
		sampler2D _Normal;
		sampler2D _Specular;
		float _Dispacment;
		float2 _p0_pi0_nc0_o2;
		float3 _p0_pi0_nc1_o4;
		float4 _p0_pi0_nc5_o3;
		float _p0_pi0_nc6_o1;
		float _p0_pi0_nc10_o0;
		float3 _p0_pi0_nc11_o6;

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
			float2 uv_Heightmap;
			float2 uv_Main;
			float4 position;
			float3 parallaxCord;

			INTERNAL_DATA
		};

		float2 CalculateParallaxUV(Input IN, float disp, sampler2D displacmentMap, float2 uv){
			float height = disp * (-0.5 + tex2D(displacmentMap, uv).x); 
			float2 texCoordOffsets = clamp(height * IN.parallaxCord.xy / IN.parallaxCord.z, -0.01f, 0.01f);  
			return uv + texCoordOffsets;
		}

		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			_p0_pi0_nc10_o0 = _Dispacment;
			_p0_pi0_nc0_o2 = CalculateParallaxUV(IN, _p0_pi0_nc10_o0, _Heightmap, IN.uv_Heightmap);
			_p0_pi0_nc5_o3 = tex2D(_Heightmap, _p0_pi0_nc0_o2);
			_p0_pi0_nc6_o1 = (_p0_pi0_nc5_o3).x;
			_p0_pi0_nc1_o4 = tex2D(_Main, _p0_pi0_nc0_o2).rgb;
			_p0_pi0_nc11_o6 = UnpackNormal(tex2D(_Normal, _p0_pi0_nc0_o2));
			o.Albedo = (_p0_pi0_nc11_o6).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
