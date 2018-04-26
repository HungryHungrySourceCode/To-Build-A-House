using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayRandomAudio : MonoBehaviour {
     public AudioSource audioSource;
    public AudioClip[] shoot;
    private AudioClip shootClip;
    // Use this for initialization
    void Start () {
        int index = Random.Range(0, shoot.Length);
        shootClip = shoot[index];
        audioSource.clip = shootClip;
        audioSource.Play();
        Destroy(this, 10f);
    }
	
	// Update is called once per frame
	void Update () {
		
	}
}
