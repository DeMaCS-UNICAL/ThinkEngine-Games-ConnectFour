using ConnectFour;
using System;
using UnityEngine;

//every method of this class returning a bool value can be used to trigger the sensors update.
public class Trigger : ScriptableObject
{
  
    public bool activeSensor()
    {
        GameController game = GameObject.FindObjectOfType<GameController>();
        if (game.pieceDrop != game.progressiveNumber)
        {
            //Debug.Log("[TRIGGER] PIECE DROP = " + game.pieceDrop + " PROGRESSIVE NUMBER = " + game.progressiveNumber);
            game.pieceDrop = game.progressiveNumber;
            //Debug.Log("{Trigger} sensore pronto");
            return true;
        }
        return false;
    }

    public bool applyActuator()
    {
        GameController game = GameObject.FindObjectOfType<GameController>();
        AggiornaK player = GameObject.FindObjectOfType<AggiornaK>();
        //Debug.Log("ATTUATORE player pogressive: " + player.currentProgressive + " pieceDrop: " + game.pieceDrop);
        if (player.currentProgressive != game.pieceDrop)
        {
            //Debug.Log("{Trigger} attuatore attivo");
            return true;
        }
        return false;
    }
}
