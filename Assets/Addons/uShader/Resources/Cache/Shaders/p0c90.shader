Shader "Hidden/uSE/Cache/p0c90" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Textures and Bumpmaps)]_Spots("Spots", 2D) = "white" {}
		_Flacks("Flacks", 2D) = "white" {}
		[NoScaleOffset]_Main("Main", 2D) = "white" {}
		[NoScaleOffset]_MetallicMap("MetallicMap", 2D) = "white" {}
		[NoScaleOffset]_PaintworkMap("PaintworkMap", 2D) = "white" {}
		[Header (Colors)]_MainTint("MainTint", Color) = (0.9779412,0.5810121,0,1)
		_MeatallicTune("MeatallicTune", Color) = (0.603,1,1,0.553)
		_SpotsTint("SpotsTint", Color) = (0.9705882,0.1405679,0,1)
		_FlacksTint("FlacksTint", Color) = (1,1,1,1)
		[Header (CubeMaps)]_Reflection("Reflection", CUBE) = "" {}
		[Header (Variables)]_CubeRefractionPower("CubeRefractionPower", float) = 0.3
		_SpotsScale("SpotsScale", float) = 10
		_SpotPower("SpotPower", float) = -0.22
		_FlacksScale("FlacksScale", float) = 3.5
		_MainTexPowerTune("MainTexPowerTune", float) = 0
		_MainTexScale("MainTexScale", float) = 1
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
		#pragma surface surf Standard 
		#include "UnityCG.cginc"
		#pragma target 4.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Spots;
		sampler2D _Flacks;
		sampler2D _Main;
		sampler2D _MetallicMap;
		sampler2D _PaintworkMap;
		float4 _MainTint;
		float4 _MeatallicTune;
		float4 _SpotsTint;
		float4 _FlacksTint;
		samplerCUBE _Reflection;
		float _CubeRefractionPower;
		float _SpotsScale;
		float _SpotPower;
		float _FlacksScale;
		float _MainTexPowerTune;
		float _MainTexScale;
		float3 _p0_pi0_nc1_o1;
		float4 _p0_pi0_nc4_o0;
		float _p0_pi0_nc4_o2;
		float _p0_pi0_nc5_o1;
		float3 _p0_pi0_nc6_o5;
		float3 _p0_pi0_nc9_o3;
		float _p0_pi0_nc10_o0;
		float3 _p0_pi0_nc11_o4;
		float2 _p0_pi0_nc16_o0;
		float _p0_pi0_nc17_o0;
		float3 _p0_pi0_nc20_o1;
		float3 _p0_pi0_nc22_o3;
		float3 _p0_pi0_nc34_o2;
		float _p0_pi0_nc36_o0;
		float3 _p0_pi0_nc37_o0;
		float3 _p0_pi0_nc38_o1;
		float3 _p0_pi0_nc40_o2;
		float3 _p0_pi0_nc41_o3;
		float _p0_pi0_nc42_o0;
		float3 _p0_pi0_nc43_o4;
		float3 _p0_pi0_nc45_o3;
		float3 _p0_pi0_nc46_o1;
		float3 _p0_pi0_nc47_o1;
		float3 _p0_pi0_nc48_o2;
		float2 _p0_pi0_nc49_o0;
		float _p0_pi0_nc50_o0;
		float3 _p0_pi0_nc52_o3;
		float3 _p0_pi0_nc67_o4;
		float3 _p0_pi0_nc69_o3;
		float3 _p0_pi0_nc70_o4;
		float4 _p0_pi0_nc71_o3;
		float _p0_pi0_nc71_o5;
		float _p0_pi0_nc72_o1;
		float _p0_pi0_nc73_o2;
		float _p0_pi0_nc74_o2;
		float3 _p0_pi0_nc75_o2;
		float _p0_pi0_nc79_o0;
		float3 _p0_pi0_nc80_o2;
		float2 _p0_pi0_nc85_o0;
		float _p0_pi0_nc86_o0;

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
			float2 uv_Spots;
			float2 uv_Flacks;
			float3 viewDir;
			float3 worldRefl;
			float4 position;

			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc1_o1 = _MainTint.rgb;
			_p0_pi0_nc4_o0 = _MeatallicTune;
			_p0_pi0_nc4_o2 = _MeatallicTune.a;
			_p0_pi0_nc5_o1 = (_p0_pi0_nc4_o0).x;
			_p0_pi0_nc6_o5 = texCUBE(_Reflection, float4(IN.worldRefl, 1.0f)).rgb;
			_p0_pi0_nc10_o0 = _CubeRefractionPower;
			_p0_pi0_nc9_o3 = lerp(_p0_pi0_nc1_o1, _p0_pi0_nc6_o5, _p0_pi0_nc10_o0);
			_p0_pi0_nc17_o0 = _SpotsScale;
			_p0_pi0_nc16_o0 = IN.uv_Spots * _p0_pi0_nc17_o0;
			_p0_pi0_nc11_o4 = tex2D(_Spots, _p0_pi0_nc16_o0).rgb;
			_p0_pi0_nc20_o1 = float4(1, 1, 1, 1).rgb;
			_p0_pi0_nc36_o0 = -0.3;
			_p0_pi0_nc37_o0 = IN.viewDir;
			_p0_pi0_nc34_o2 = _p0_pi0_nc36_o0 - _p0_pi0_nc37_o0;
			_p0_pi0_nc22_o3 = lerp(_p0_pi0_nc11_o4, _p0_pi0_nc20_o1, _p0_pi0_nc34_o2);
			_p0_pi0_nc38_o1 = _SpotsTint.rgb;
			_p0_pi0_nc40_o2 = (_p0_pi0_nc22_o3 + _p0_pi0_nc38_o1);
			_p0_pi0_nc42_o0 = _SpotPower;
			_p0_pi0_nc41_o3 = lerp(_p0_pi0_nc9_o3, _p0_pi0_nc40_o2, _p0_pi0_nc42_o0);
			_p0_pi0_nc50_o0 = _FlacksScale;
			_p0_pi0_nc46_o1 = _FlacksTint.rgb;
			_p0_pi0_nc47_o1 = float4(0, 0, 0, 1).rgb;
			_p0_pi0_nc49_o0 = IN.uv_Spots * _p0_pi0_nc50_o0;
			_p0_pi0_nc43_o4 = tex2D(_Flacks, _p0_pi0_nc49_o0).rgb;
			_p0_pi0_nc45_o3 = lerp(_p0_pi0_nc46_o1, _p0_pi0_nc47_o1, _p0_pi0_nc43_o4);
			_p0_pi0_nc52_o3 = lerp(_p0_pi0_nc45_o3, _p0_pi0_nc47_o1, _p0_pi0_nc34_o2);
			_p0_pi0_nc48_o2 = (_p0_pi0_nc52_o3 + _p0_pi0_nc41_o3);
			_p0_pi0_nc86_o0 = _MainTexScale;
			_p0_pi0_nc85_o0 = IN.uv_Spots * _p0_pi0_nc86_o0;
			_p0_pi0_nc70_o4 = tex2D(_PaintworkMap, IN.uv_Spots).rgb;
			_p0_pi0_nc71_o3 = tex2D(_MetallicMap, IN.uv_Spots);
			_p0_pi0_nc71_o5 = tex2D(_MetallicMap, IN.uv_Spots).a;
			_p0_pi0_nc72_o1 = (_p0_pi0_nc71_o3).x;
			_p0_pi0_nc73_o2 = (_p0_pi0_nc5_o1 * _p0_pi0_nc72_o1);
			_p0_pi0_nc74_o2 = (_p0_pi0_nc4_o2 * _p0_pi0_nc71_o5);
			_p0_pi0_nc79_o0 = _MainTexPowerTune;
			_p0_pi0_nc80_o2 = _p0_pi0_nc70_o4 * _p0_pi0_nc79_o0;
			_p0_pi0_nc67_o4 = tex2D(_Main, _p0_pi0_nc85_o0).rgb;
			_p0_pi0_nc75_o2 = (_p0_pi0_nc67_o4 * _p0_pi0_nc48_o2);
			_p0_pi0_nc69_o3 = lerp(_p0_pi0_nc75_o2, _p0_pi0_nc48_o2, _p0_pi0_nc80_o2);
			o.Albedo = (float3(1.0f, 1.0f, 1.0f)).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
