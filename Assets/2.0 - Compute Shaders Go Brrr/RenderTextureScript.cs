using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RenderTextureScript: MonoBehaviour {

    [SerializeField]
    private ComputeShader _shader;
    [SerializeField]
    private int _size = 256;

    private Renderer _renderer;
    private RenderTexture _texture;

    void Awake() {
        _texture = new RenderTexture(_size, _size, 24); // 24 for depth of RGBA

        /*
            Required in order to provide random access and to pass texture
            from the shader to this texture.          
        */      
        _texture.enableRandomWrite = true;
        _texture.Create();

        _renderer = GetComponent<Renderer>();
    }

    void Update() {
        int kernel = _shader.FindKernel("ClearBoard");

        _shader.SetTexture(kernel, "Result", _texture);
        _shader.Dispatch(kernel, _size / 8, _size / 8, 1);

        _renderer.material.SetTexture("_MainTex", _texture);
    }
}
