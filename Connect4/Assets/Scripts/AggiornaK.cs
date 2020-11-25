using ConnectFour;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AggiornaK : MonoBehaviour
{
    public int riga;
    public int col;
    public int precCol;
    public int precRiga;
    GameController gridSensor;
    public int currentProgressive;
    public int aiProgressive;
    // Start is called before the first frame update
    void Start()
    {
        gridSensor = GameObject.FindObjectOfType<GameController>();
        riga = 5;
        col = 3;
        precCol = col-1;
        precRiga = riga - 1;
        currentProgressive = -1;
        aiProgressive = -1;
    }

    // Update is called once per frame
    void Update()
    {
        if(currentProgressive != aiProgressive)
        {
            Debug.Log("[AGGIORNAK]: Current progressive = " + currentProgressive + " AIprogressive = " + aiProgressive);
            currentProgressive = aiProgressive;
            gridSensor.K = col;
            if (col != precCol || riga != precRiga)
            {
                precCol = col;
                precRiga = riga;
                Debug.Log("AGGORNA K: Riga: " + riga + " Col: " + col);
            }
        }
    }
}
