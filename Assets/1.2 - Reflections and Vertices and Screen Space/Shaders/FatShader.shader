Shader "Surface/FatShader" {

    Properties {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _ExtrudeAmount("Extrude Multiplier", Range(0, 1)) = 1
    }
    
    SubShader {
    
        Tags {
            "RenderType" = "Opaque"
        }
        
        LOD 200

        CGPROGRAM
        
        #pragma surface surf Standard vertex:vert
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
        };
        
        sampler2D _MainTex;
        float _ExtrudeAmount;
        
        void vert(inout appdata_full data) {
            float timeOffset = sin(_Time.z) / 2 + 0.5;
            data.vertex.xyz += data.normal * _ExtrudeAmount * timeOffset;
        }

        void surf(Input data, inout SurfaceOutputStandard o) {
            o.Albedo = tex2D(_MainTex, data.uv_MainTex);
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
