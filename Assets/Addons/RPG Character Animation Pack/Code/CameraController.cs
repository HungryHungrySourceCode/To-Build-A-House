using UnityEngine;
using System.Collections;

public class CameraController : MonoBehaviour
{
    [Header("Initialization")]
    public Transform player;
    public float followSpeed;
    public float height;
    public float z_offset;

    public float directionPredictStrength = 1f;
    public Vector3 targetPos;

    // Use this for initialization
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        targetPos = GetOffset();

        if ((transform.position - targetPos).magnitude >= 1f)
        {
            transform.position += ((targetPos - transform.position) * followSpeed);
        }
        //transform.LookAt(player);
    }

    public Vector3 GetOffset()
    {
        Vector3 mousePos = mousePosition();
        return new Vector3(player.position.x + ((mousePos.x - player.position.x) * directionPredictStrength), player.position.y + height, player.position.z + z_offset + ((mousePos.z - player.position.z) * directionPredictStrength));
    }

    Vector3 mousePosition()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, 1000))
        {
            return hit.point;
        }
        else
        {
            return new Vector3(0, 0, 0);
        }
    }
}