Shader "Surface/CelestialShader" {

    Properties {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Emission("Emission", Range(0, 1)) = 1
        _RollSpeed("Roll Speed", Float) = 0.5
    }
    
    SubShader {
    
        Tags {
            "RenderType" = "Opaque"
        }
        
        LOD 200

        CGPROGRAM
        
        #pragma surface surf Standard
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
            float4 screenPos;
        };
        
        sampler2D _MainTex;
        float _Emission;
        float _RollSpeed;

        void surf(Input data, inout SurfaceOutputStandard o) {
            float2 screenUV = data.screenPos.xy / data.screenPos.w;
            screenUV.x += _Time.x * _RollSpeed;
        
            float4 c = tex2D(_MainTex, screenUV);
            
            o.Albedo = c.rgb;
            o.Emission = c.rgb * _Emission;
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
