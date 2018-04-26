using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightDieDown : MonoBehaviour {
    public Light lightRef;
    public float lossPerCheck = 5f;

	
	// Update is called once per frame
	void Update () {
        lightRef.intensity -= lossPerCheck;
	}
}
