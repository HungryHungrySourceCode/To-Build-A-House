Shader "Hidden/uSE/Cache/p0c45" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Tessellation config)]
		_Displacement_("Displacement", float) = -0.29
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
		[Header (Variables)]_Noisetexcoords("Noise texcoords", Vector) = (10,10,0,0)
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
		#pragma surface surf Standard addshadow 
		#include "UnityCG.cginc"
		#pragma target 5.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Texture;
		float2 _Noisetexcoords;
		float _Displacement_;
		uniform float4 _DispMap_ST;
		float3 _p0_pi0_nc44_o0;
		float _p0_pi0_nc46_o0;
		float3 _p0_pi0_nc47_o2;
		float _p0_pi2_nc3_o2;
		float4 _p0_pi2_nc8_o7;
		float4 _p0_pi2_nc19_o0;
		float _p0_pi2_nc23_o0;
		float2 _p0_pi2_nc24_o1;
		float2 _p0_pi2_nc25_o2;
		float2 _p0_pi2_nc26_o0;

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
			float4 color : COLOR;
			float4 position;

			INTERNAL_DATA
		};
		 uniform sampler2D _PermutationTable;

		uint perm(uint d, sampler2D map)
		{
			d = d % 256;
			float4 t = float4(d%16,d/16,1,0)/15.0;
			return tex2Dlod(map, t).r *255;
		}

		float fade(float t) { return t *t * t * (t * (t * 6.0 - 15.0) + 10.0); }

		float lerpPN(float t,float a,float b) { return a + t * (b - a); }

		float grad(uint hash,float x,float y,float z)
		{
			uint h	= hash % 16;
			float u = h<8 ? x : y;
			float v = h<4 ? y : (h==12||h==14 ? x : z);
			return ((h%2) == 0 ? u : -u) + (((h/2)%2) == 0 ? v : -v);
		}

		float noise(float x, float y, float z, sampler2D map)
		{	
			uint X = (uint)floor(x) % 256;	// & 255;
			uint Y = (uint)floor(y) % 256;	// & 255;
			uint Z = (uint)floor(z) % 256;	// & 255;

			x -= floor(x);
			y -= floor(y);
			z -= floor(z);

			float u = fade(x);
			float v = fade(y);
			float w = fade(z);

			uint A	= perm(X  , map)+Y;
			uint AA	= perm(A  , map)+Z;
			uint AB	= perm(A+1, map)+Z;
			uint B	= perm(X+1, map)+Y;
			uint BA	= perm(B  , map)+Z;
			uint BB	= perm(B+1, map)+Z;

			return lerpPN(w, lerpPN(v, lerpPN(u, grad(perm(AA, map), x  , y  , z   ),
		 								   grad(perm(BA, map), x-1, y  , z   )),
		 						   lerpPN(u, grad(perm(AB, map), x  , y-1, z   ),
		 								   grad(perm(BB, map), x-1, y-1, z   ))),
		 				   lerpPN(v, lerpPN(u, grad(perm(AA+1, map), x  , y  , z-1 ),
		 								   grad(perm(BA+1, map), x-1, y  , z-1 )),
		 					   lerpPN(u, grad(perm(AB+1, map), x  , y-1, z-1 ),
		 							   grad(perm(BB+1, map), x-1, y-1, z-1 ))));
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc44_o0 = IN.color.rgb;
			_p0_pi0_nc46_o0 = 0.3;
			_p0_pi0_nc47_o2 = _p0_pi0_nc44_o0 * _p0_pi0_nc46_o0;
			o.Albedo = (_p0_pi0_nc47_o2).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
