// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Glass" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Refractionmap("Refraction map", 2D) = "white" {}
		_Specular("Specular", 2D) = "white" {}
		[Header (Variables)]_RefractionPower("RefractionPower", float) = 0.28
		_Brightness("Brightness", float) = 0.15
		_NormalMaping("NormalMaping", float) = -0.3
		_Occlusion("Occlusion", float) = 1
		_Smoothness("Smoothness", float) = 1
		_SpecularPower("SpecularPower", float) = -0.6
		_TimePreview("TimePreview", float) = 0
		_Var2("Var2", float) = 0.1
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Transparent"
			"RenderType" = "Opaque"
		}

		Fog {
			Mode Global
			Density 0
			Color (1, 1, 1, 1) 
			Range 0, 300
		}

		GrabPass {
			Name "BASE"
		}

		Stencil {
			Ref 0
			Comp Always
			Pass Keep
			Fail Keep
			ZFail Keep
		}

		Cull Back
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf StandardSpecular alpha vertex:vert fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Refractionmap;
		sampler2D _Specular;
		float _RefractionPower;
		float _Brightness;
		float _NormalMaping;
		float _Occlusion;
		float _Smoothness;
		float _SpecularPower;
		float _TimePreview;
		float _Var2;
		sampler2D _GrabTexture : register(s0);
		uniform half4 _GrabTexture_TexelSize;
		float _p0_pi0_nc22_o0;
		float3 _p0_pi0_nc26_o4;
		float3 _p0_pi0_nc26_o6;
		float _p0_pi0_nc27_o1;
		float3 _p0_pi0_nc29_o3;
		float3 _p0_pi0_nc35_o4;
		float3 _p0_pi0_nc35_o6;
		float3 _p0_pi0_nc36_o2;
		float _p0_pi0_nc38_o0;
		float _p0_pi0_nc39_o0;
		float3 _p0_pi0_nc40_o2;
		float _p0_pi0_nc41_o0;
		float _p0_pi0_nc43_o2;
		float _p0_pi0_nc44_o0;
		float _p0_pi0_nc45_o2;
		float _p0_pi0_nc46_o0;
		float3 _p0_pi0_nc47_o2;
		float _p0_pi0_nc50_o0;
		float _p0_pi0_nc51_o0;
		float _p0_pi0_nc52_o0;
		float2 _p0_pi0_nc53_o2;
		float _p0_pi0_nc54_o2;
		float2 _p0_pi0_nc55_o0;
		float2 _p0_pi0_nc56_o5;
		float _p0_pi0_nc57_o0;

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
			float2 uv_Refractionmap;
			float2 uv_Specular;
			float4 position;
			float4 projGrab;

			INTERNAL_DATA
		};

		void vert (inout appdata v, out Input IN){
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN.position = UnityObjectToClipPos(v.vertex);
			IN.projGrab = ComputeScreenPos(IN.position);
			COMPUTE_EYEDEPTH(IN.projGrab.z);
			#if UNITY_UV_STARTS_AT_TOP
				IN.projGrab.y = (IN.position.w - IN.position.y) * 0.494f;
			#endif
		}

		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			_p0_pi0_nc22_o0 = _RefractionPower;
			_p0_pi0_nc55_o0 = IN.uv_Refractionmap;
			_p0_pi0_nc57_o0 = 0;
			_p0_pi0_nc51_o0 = _TimePreview;
			_p0_pi0_nc52_o0 = _Var2;
			_p0_pi0_nc54_o2 = (_p0_pi0_nc51_o0 * _p0_pi0_nc52_o0);
			_p0_pi0_nc56_o5 = float2(_p0_pi0_nc54_o2, _p0_pi0_nc57_o0);
			_p0_pi0_nc38_o0 = _Brightness;
			_p0_pi0_nc53_o2 = (_p0_pi0_nc55_o0 + _p0_pi0_nc56_o5);
			_p0_pi0_nc39_o0 = _NormalMaping;
			_p0_pi0_nc26_o6 = UnpackNormal(tex2D(_Specular, _p0_pi0_nc53_o2));
			_p0_pi0_nc41_o0 = _Occlusion;
			_p0_pi0_nc35_o4 = tex2D(_Refractionmap, _p0_pi0_nc53_o2).rgb;
			_p0_pi0_nc44_o0 = _Smoothness;
			_p0_pi0_nc27_o1 = normalize(_p0_pi0_nc35_o4).x;
			_p0_pi0_nc46_o0 = _SpecularPower;
			_p0_pi0_nc26_o4 = tex2D(_Specular, _p0_pi0_nc53_o2).rgb;
			_p0_pi0_nc50_o0 = 0.8;
			_p0_pi0_nc35_o6 = UnpackNormal(tex2D(_Refractionmap, _p0_pi0_nc53_o2));
			_p0_pi0_nc29_o3 = tex2Dproj(_GrabTexture, IN.projGrab + abs(_p0_pi0_nc35_o6.r * _p0_pi0_nc35_o6.g * _p0_pi0_nc35_o6.b * _p0_pi0_nc22_o0 - _p0_pi0_nc22_o0 / 16 ) - _p0_pi0_nc22_o0 / 8 + _p0_pi0_nc22_o0 / 15);
			_p0_pi0_nc47_o2 = _p0_pi0_nc26_o4 * _p0_pi0_nc46_o0;
			_p0_pi0_nc45_o2 = (_p0_pi0_nc27_o1 * _p0_pi0_nc44_o0);
			_p0_pi0_nc40_o2 = _p0_pi0_nc26_o6 * _p0_pi0_nc39_o0;
			_p0_pi0_nc43_o2 = (_p0_pi0_nc41_o0 * _p0_pi0_nc27_o1);
			_p0_pi0_nc36_o2 = (_p0_pi0_nc29_o3 + _p0_pi0_nc38_o0);
			o.Smoothness = _p0_pi0_nc45_o2;
			o.Specular = _p0_pi0_nc47_o2;
			o.Occlusion = _p0_pi0_nc43_o2;
			o.Albedo = _p0_pi0_nc36_o2;
			o.Normal = _p0_pi0_nc40_o2;
			o.Alpha = _p0_pi0_nc50_o0;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
