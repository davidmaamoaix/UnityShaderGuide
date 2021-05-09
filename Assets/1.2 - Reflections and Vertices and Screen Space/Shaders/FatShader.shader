Shader "Surface/FatShader" {

    Properties {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        
        /*
            Controls the amount (scale) of extrusion.
        */
        _ExtrudeAmount("Extrude Multiplier", Range(0, 1)) = 1
    }
    
    SubShader {
    
        Tags {
            "RenderType" = "Opaque"
        }
        
        LOD 200

        CGPROGRAM
        
        /*
            'vertex:<funcName>' uses the specified function as the vertex
            shader.
            
            In short, vertex shaders are called per vertex and can manipulate
            vertex properties such as vertex position.
        */
        #pragma surface surf Standard vertex:vert
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
        };
        
        sampler2D _MainTex;
        float _ExtrudeAmount;
        
        void vert(inout appdata_full data) {
            
            /*
                Changes the extrusion amount over time.
            */
            float timeOffset = sin(_Time.z) / 2 + 0.5;
            
            /*
                Offsets each vertex by its normal, which moves them outwards.
            */
            data.vertex.xyz += data.normal * _ExtrudeAmount * timeOffset;
        }

        void surf(Input data, inout SurfaceOutputStandard o) {
            o.Albedo = tex2D(_MainTex, data.uv_MainTex);
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
