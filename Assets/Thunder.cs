using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Thunder : MonoBehaviour {
    public float distance;
    public Vector2 randomRange;
    public GameObject LightningStrike;
    private bool breakCo = false;
    private void Start()
    {
        StartCoroutine(thunder());
        breakCo = false;
    }

    private void OnEnable()
    {
        StartCoroutine(thunder());
        breakCo = false;
    }

    private void OnDisable()
    {
         breakCo = true;
    }

    public IEnumerator thunder()
    {
        while (true)
        {
            Vector3 origin = new Vector3(transform.position.x + Random.Range(-distance, distance), transform.position.y + 30f, transform.position.z + Random.Range(distance, -distance));
            Ray ray;
            RaycastHit hit;
            if (Physics.Raycast(origin,  Vector3.down, out hit, 200f))
            {
                Instantiate(LightningStrike, hit.point, Quaternion.identity);
            }
            yield return new WaitForSeconds(Random.Range(randomRange.x, randomRange.y));
            if (breakCo == true)
            {
                yield break;
            }
        }
    }
}
