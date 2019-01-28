Shader "Custom/ScrollingUVs" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_ScrollXSpeed("X Scroll Speed",Range(0,10)) = 2 //控制X方向的速度
		_ScrollYSpeed("Y Scroll Speed", Range(0,10)) = 2 //控制Y方向的速度
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
       
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;
		sampler2D _MainTex;
		fixed4 _Color;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			//在我们将UV传递给tex2D()函数之前，创建一个单独的变量来储存我们的UVs
			fixed2 scrolledUV = IN.uv_MainTex;
			//创建存储单个x和y分量的变量，以备UV随时间的缩放
			fixed xScrollValue = _ScrollXSpeed * _Time;
			fixed yScrollValue = _ScrollYSpeed * _Time;
			//应用最终的UV偏移
			scrolledUV += fixed2(xScrollValue, yScrollValue);

			//应用纹理和色彩
			half4 c = tex2D(_MainTex, scrolledUV);
			o.Albedo = c.rgb * _Color;
			o.Alpha = c.a;

		}
		ENDCG
	}
	FallBack "Diffuse"
}
