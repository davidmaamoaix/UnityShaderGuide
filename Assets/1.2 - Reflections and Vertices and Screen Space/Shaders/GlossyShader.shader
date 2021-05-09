Shader "Surface/GlossyShader" {

    Properties {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        
        /*
            Adds a slider to control the Albedo intensity (since the
            reflection is going to be the dominant factor in this example).
        */
        _AlbedoScale("Albedo Scale", Range(0, 1)) = 0.2
    }
    
    SubShader {
    
        Tags {
            "RenderType" = "Opaque"
        }
        
        LOD 200

        CGPROGRAM
        
        #pragma surface surf Standard
        #pragma target 3.0
        
        /*
            This includes some helper functions provided by Unity.
            
            For a list of all members, see:
            https://docs.unity3d.com/Manual/SL-BuiltinFunctions.html
        */
        #include "UnityCG.cginc"

        struct Input {
            float2 uv_MainTex;
            
            /*
                Obtains the reflection vector in world space.
            */
            float3 worldRefl;
        };
        
        sampler2D _MainTex;
        float _AlbedoScale;

        void surf(Input data, inout SurfaceOutputStandard o) {
            float3 norm = data.worldRefl;
            
            /*
                'UNITY_SAMPLE_TEXCUBE' samples a cube map (similar to 'tex2D').
                
                'unity_SpecCube0' contains data for the active reflection probe.
            */
            float4 value = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, norm);
            
            /*
                'DecodeHDR' decodes cube map data into color.
            */
            o.Emission = DecodeHDR(value, unity_SpecCube0_HDR);
        
            /*
                Assigns the texture value to the output's color field.
                
                The scaling is to prevent the color from being too bright
                when adding the emission value.
            */
            o.Albedo = tex2D(_MainTex, data.uv_MainTex) * _AlbedoScale;
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
