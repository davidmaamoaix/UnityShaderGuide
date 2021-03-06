Shader "Surface/TexturedShader" {

    /*
        The 'Properties' section is used to define editable properties of a
        material (in the inspector).
        
        The syntax for declaring a property is:
        '<varName> ("<displayName>", <type>) = <defaultValue>'
        
        <varName> should begin with an underscore '_'.
        A full list of <type> can be found here:
        https://docs.unity3d.com/Manual/SL-Properties.html
    */
    Properties {
    
        /*
            '2D' is basically a texture that can be assigned from the inspector
            or from code.
        */
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _NormalTex("Normal Map", 2D) = "bump" {}
        
        /*
            '[Toggle]' is a MaterialPropertyDrawer that renders the
            property as a checkbox that can be toggled (1 for active and 0 for
            inactive).
        */
        [Toggle]
        _EnableRim("Enable Rim", Float) = 0
        
        /*
            'Color' is a float4 that represents a RGBA color.
        */
        _RimColor("Rim Color", Color) = (1, 1, 1, 1)
        
        /*
            'Range' specifies a property with an adjustable slider.
        */
        _RimPower("Rim Power", Range(0.5, 20)) = 2
    }
    
    SubShader {
    
        Tags {
            "RenderType" = "Opaque"
        }
        
        LOD 200

        CGPROGRAM
        
        /*
            'Lambert' is a diffuse light model. The output accepts a
            'SurfaceOutput' instead of the previously used
            'SurfaceOutputStandard'.
        */
        #pragma surface surf Lambert
        #pragma target 3.0
        
        /*
            The input structure is more verbose than the one in the previous
            example, as this shader needs more information during rendering.
            A full list of possible input variables can be found here:
            https://docs.unity3d.com/Manual/SL-SurfaceShaders.html
        */
        struct Input {
        
            /*
                The UV coordinate of the current 'pixel' of the main texture.
                This allows sampling the pixel color of the texture in the
                shader code.
            */
            float2 uv_MainTex;
            
            /*
                The UV coordinate of the normal map. This is distinct from
                'uv_MainTex' as factors such as tiling and offset can be changed
                per texture, resulting in different UV coordinates.
            */
            float2 uv_NormalTex;
            
            /*
                The view direction of the camera, as a vector. This is useful
                when computing light behaviors that are dependent on the viewing
                angle, such as specular.
            */
            float3 viewDir;
        };
        
        /*
            Declaring properties in the properties section does not involve them
            to the HLSL code you are writing. To do so, declaring the variables
            (with the same variable name as the properties) in the HLSL global
            scope is needed to allow Unity to populate them with the values from
            the properties of the associated material.
             
            Note that '2D' is just sampler2D in HLSL.
        */
        sampler2D _MainTex;
        sampler2D _NormalTex;
        float _EnableRim;
        float4 _RimColor;
        float _RimPower;

        void surf(Input data, inout SurfaceOutput o) {
        
            /*
                'tex2D' takes in a texture sampler and a UV coordinate and
                returns the value of the texture at that coordinate.
            */
            o.Albedo = tex2D(_MainTex, data.uv_MainTex).rgb;
            
            /*
                The same is done with the normal map; however, normal map has
                a different pixel structure from a texture map, and therefore
                needs to be processed by 'UnpackNormal'.
                
                For the specific role and implementation of 'UnpackNormal',
                check the documentation.
            */
            o.Normal = UnpackNormal(tex2D(_NormalTex, data.uv_NormalTex));
            
            /*
                The rim lighting effect is created by increasing the emission
                of 'pixels' whose normal is more perpendicular to the viewing
                vector.
            */
            float rim = 1 - saturate(dot(normalize(data.viewDir), o.Normal));
            o.Emission = _RimColor * pow(rim, _RimPower) * _EnableRim;
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
