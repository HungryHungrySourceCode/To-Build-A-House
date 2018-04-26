Shader "Hidden/Tesselation+Reflaction" { 
	Properties { 
		[Header (Tessellation config)]
		_TessMultiplier_("Polygons multiplier", float) = 24
		_Displacement_("Displacement", float) = 0.15
		[Header (Textures and Bumpmaps)]_Brdfmap("Brdf map", 2D) = "white" {}
		_DispMap("DispMap", 2D) = "white" {}
		[Header (CubeMaps)]_Cubmap("Cubmap", CUBE) = "" {}
		[Header (Variables)]_TimePreview("TimePreview", float) = 0
		_Var("Var", float) = 0.1
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
		#pragma surface surf Standard vertex:vert addshadow fullforwardshadows tessellate:tess 
		#pragma target 5.0
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"

		sampler2D _Brdfmap;
		sampler2D _DispMap;
		samplerCUBE _Cubmap;
		float _TimePreview;
		float _Var;
		float _TessMultiplier_;
		float _Displacement_;
		uniform float4 _DispMap_ST;
		float3 _p0_pi0_nc22_o4;
		float _p0_pi0_nc24_o1;
		float3 _p0_pi0_nc26_o1;
		float3 _p0_pi0_nc28_o1;
		float2 _p0_pi0_nc31_o0;
		float2 _p0_pi0_nc32_o5;
		float _p0_pi0_nc33_o0;
		float _p0_pi0_nc34_o0;
		float2 _p0_pi0_nc37_o2;
		float _p0_pi0_nc38_o0;
		float _p0_pi0_nc39_o2;
		float _p0_pi2_nc1_o0;
		float4 _p0_pi2_nc3_o3;
		float4 _p0_pi2_nc5_o2;
		float _p0_pi2_nc6_o0;
		float2 _p0_pi2_nc7_o1;
		float _p0_pi2_nc8_o0;
		float _p0_pi2_nc9_o0;
		float2 _p0_pi2_nc11_o5;
		float2 _p0_pi2_nc13_o2;
		float _p0_pi2_nc14_o0;
		float _p0_pi2_nc15_o2;

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
			float2 uv_Brdfmap;
			float2 uv_DispMap;
			float4 position;

			INTERNAL_DATA
		};

		float4 tess (appdata v0, appdata v1, appdata v2) {
			float minDist = 10.0;
			float maxDist = 25.0;
			return UnityDistanceBasedTess(v0.vertex, v1.vertex, v2.vertex, minDist, maxDist, _TessMultiplier_);

		}

		void vert (inout appdata v){
			_p0_pi2_nc1_o0 = 1;
			_p0_pi2_nc7_o1 = v.texcoord.xy;
			_p0_pi2_nc6_o0 = 1;
			_p0_pi2_nc9_o0 = 0;
			_p0_pi2_nc8_o0 = _TimePreview;
			_p0_pi2_nc14_o0 = _Var;
			_p0_pi2_nc15_o2 = (_p0_pi2_nc8_o0 * _p0_pi2_nc14_o0);
			_p0_pi2_nc11_o5 = float2(_p0_pi2_nc15_o2, _p0_pi2_nc9_o0);
			_p0_pi2_nc13_o2 = (_p0_pi2_nc7_o1 + _p0_pi2_nc11_o5);
			_p0_pi2_nc3_o3 = tex2Dlod(_DispMap, float4((_p0_pi2_nc13_o2).x, (_p0_pi2_nc13_o2).y, 1.0f, 0.0f) * _p0_pi2_nc1_o0);
			_p0_pi2_nc5_o2 = (_p0_pi2_nc3_o3 - _p0_pi2_nc6_o0);
			float disp = (_p0_pi2_nc5_o2).r * _Displacement_;
			v.vertex.xyz += v.normal * disp;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc31_o0 = IN.uv_Brdfmap;
			_p0_pi0_nc34_o0 = 0;
			_p0_pi0_nc26_o1 = float4(0.3676471, 0.3676471, 0.3676471, 1).rgb;
			_p0_pi0_nc28_o1 = float4(0.2426471, 0.2426471, 0.2426471, 1).rgb;
			_p0_pi0_nc33_o0 = _TimePreview;
			_p0_pi0_nc38_o0 = _Var;
			_p0_pi0_nc39_o2 = (_p0_pi0_nc33_o0 * _p0_pi0_nc38_o0);
			_p0_pi0_nc32_o5 = float2(_p0_pi0_nc39_o2, _p0_pi0_nc34_o0);
			_p0_pi0_nc37_o2 = (_p0_pi0_nc31_o0 + _p0_pi0_nc32_o5);
			_p0_pi0_nc22_o4 = tex2D(_DispMap, _p0_pi0_nc37_o2).rgb;
			_p0_pi0_nc24_o1 = (_p0_pi0_nc22_o4).x;
			o.Albedo = _p0_pi0_nc26_o1;
			o.Emission = _p0_pi0_nc28_o1;
			o.Occlusion = _p0_pi0_nc24_o1;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
