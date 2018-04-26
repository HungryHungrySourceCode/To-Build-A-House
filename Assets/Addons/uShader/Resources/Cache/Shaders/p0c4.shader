Shader "Hidden/uSE/Cache/p0c4" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[HideInInspector] _Control ("Control (RGBA)", 2D) = "red" {}
		[HideInInspector] _Splat3 ("Layer 3 (A)", 2D) = "white" {}
		[HideInInspector] _Splat2 ("Layer 2 (B)", 2D) = "white" {}
		[HideInInspector] _Splat1 ("Layer 1 (G)", 2D) = "white" {}
		[HideInInspector] _Splat0 ("Layer 0 (R)", 2D) = "white" {}
		[HideInInspector] _Normal3 ("Normal 3 (A)", 2D) = "bump" {}
		[HideInInspector] _Normal2 ("Normal 2 (B)", 2D) = "bump" {}
		[HideInInspector] _Normal1 ("Normal 1 (G)", 2D) = "bump" {}
		[HideInInspector] _Normal0 ("Normal 0 (R)", 2D) = "bump" {}
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"SplatCount" = "4"
		}

		Cull Off
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf Standard addshadow 
		#include "UnityCG.cginc"
		#pragma target 4.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		uniform sampler2D _Control;
		uniform sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
		uniform sampler2D _Normal0,_Normal1,_Normal2,_Normal3;
		float3 _p0_pi0_nc0_o0;
		float3 _p0_pi0_nc1_o0;

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
			float2 uv_Control;
			float2 uv_Splat0;
			float2 uv_Splat1;
			float2 uv_Splat2;
			float2 uv_Splat3;
			float2 texcoord : TEXCOORD0;
			float2 texcoord1 : TEXCOORD1;
			float3 worldPos;
			float4 position;

			INTERNAL_DATA
		};

		inline half4 DiffuseLight (half3 lightDir, half3 normal, half4 color) {
			#ifndef USING_DIRECTIONAL_LIGHT
			lightDir = normalize(lightDir);
			#endif
			half diffuse = dot(normal * 2 -1, lightDir);
			half4 c;
			c.rgb = clamp(0, color.rgb, color.rgb * (diffuse) + color.rgb);
			c.a = 0;
			return c;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 splat_control = tex2D (_Control, IN.uv_Control);
			fixed3 terrainDataColorMul = splat_control.r * tex2D (_Splat0, IN.uv_Splat0).rgb + splat_control.g * tex2D (_Splat1, IN.uv_Splat1).rgb + splat_control.b * tex2D (_Splat2, IN.uv_Splat2).rgb + splat_control.a * tex2D (_Splat3, IN.uv_Splat3).rgb;
			fixed3 terrainDataNormalMul = splat_control.r * tex2D (_Normal0, IN.uv_Splat0).rgb + splat_control.g * tex2D (_Normal1, IN.uv_Splat1).rgb + splat_control.b * tex2D (_Normal2, IN.uv_Splat2).rgb + splat_control.a * tex2D (_Normal3, IN.uv_Splat3).rgb;
			_p0_pi0_nc0_o0 = terrainDataColorMul;
			_p0_pi0_nc1_o0 = terrainDataNormalMul;
			o.Albedo = (_p0_pi0_nc0_o0).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
