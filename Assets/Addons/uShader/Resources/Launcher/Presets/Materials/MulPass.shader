// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/MulPass" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
		_Texture2("Texture2", 2D) = "white" {}
		[Header (Colors)]_Color("Color", Color) = (1,1,1,1)
		[Header (Variables)]_TimePreview("TimePreview", float) = 0
		_Var2("Var2", float) = 0.1
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

		Cull Back
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf Lambert alpha vertex:vert addshadow fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Texture;
		sampler2D _Texture2;
		float4 _Color;
		float _TimePreview;
		float _Var2;
		float3 _p0_pi0_nc0_o4;
		float _p0_pi0_nc0_o5;
		float _p0_pi0_nc3_o0;
		float _p0_pi0_nc4_o0;
		float _p0_pi0_nc5_o2;
		float _p0_pi0_nc7_o0;
		float2 _p0_pi0_nc8_o5;
		float2 _p0_pi0_nc9_o0;
		float2 _p0_pi0_nc12_o2;
		float _p0_pi0_nc14_o2;
		float3 _p0_pi0_nc16_o2;
		float3 _p0_pi0_nc20_o1;

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
			float2 uv_Texture2;
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
		float Posterize(float chanel, int steps)
		{
			if(steps < 1)
				steps = 255;
			float block = 1.0f/(float)steps;
			float result = 0;
			while(chanel > result + block)
			{
				   result += block;
			}
			return result;
		}

		void vert (inout appdata v, out Input IN){
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN.position = UnityObjectToClipPos(v.vertex);
		}

		void surf (Input IN, inout SurfaceOutput o) {
			_p0_pi0_nc3_o0 = _TimePreview;
			_p0_pi0_nc9_o0 = IN.uv_Texture;
			_p0_pi0_nc4_o0 = _Var2;
			_p0_pi0_nc5_o2 = (_p0_pi0_nc3_o0 * _p0_pi0_nc4_o0);
			_p0_pi0_nc7_o0 = 0;
			_p0_pi0_nc8_o5 = float2(_p0_pi0_nc5_o2, _p0_pi0_nc7_o0);
			_p0_pi0_nc12_o2 = (_p0_pi0_nc9_o0 + _p0_pi0_nc8_o5);
			_p0_pi0_nc0_o5 = tex2D(_Texture2, _p0_pi0_nc12_o2).a;
			_p0_pi0_nc0_o4 = tex2D(_Texture2, _p0_pi0_nc12_o2).rgb;
			_p0_pi0_nc14_o2 = noise(IN.position.x, IN.position.y, 1.0f, _Texture2);
			_p0_pi0_nc20_o1 = _Color.rgb;
			_p0_pi0_nc16_o2 = (_p0_pi0_nc20_o1 + _p0_pi0_nc14_o2);
			o.Albedo = _p0_pi0_nc16_o2;
			o.Alpha = _p0_pi0_nc0_o5;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
