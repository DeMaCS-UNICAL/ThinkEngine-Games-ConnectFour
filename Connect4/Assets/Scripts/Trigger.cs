using ConnectFour;
using System;
using UnityEngine;

//every method of this class returning a bool value can be used to trigger the sensors update.
public class Trigger : ScriptableObject
{
    GameController game;
    AggiornaK player;
    public int pieceDrop;
    
    void Awake()
    {
        game = GameObject.FindObjectOfType<GameController>();
        player = GameObject.FindObjectOfType<AggiornaK>();
        //if(game.field.IsPlayersTurn)
        //    pieceDrop = 0;
        pieceDrop = -1;
    }
  
    public bool activeSensor()
    {
        if(pieceDrop != game.progressiveNumber)
        {
            Debug.Log("[TRIGGER] PIECE DROP = " + pieceDrop + " PROGRESSIVE NUMBER = " + game.progressiveNumber);
            pieceDrop = game.progressiveNumber;
            Debug.Log("{Trigger} sensore pronto");
            return true;
        }
        return false;
    }

    public bool applyActuator()
    {
        Debug.Log("ATTUATORE player pogressive: " + player.currentProgressive + " pieceDrop: " + pieceDrop);
        if (player.currentProgressive != pieceDrop)
        {
            Debug.Log("{Trigger} attuatore attivo");
            return true;
        }
        return false;
    }
}
