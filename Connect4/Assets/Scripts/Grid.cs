using ConnectFour;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Video;

public class Cell
{
    int content;
    int x;
    int y;

    public int Content { get { return this.content; } set { this.content = value; } }

    public int X { get { return this.x; } set { this.x = value; } }

    public int Y { get { return this.y; } set { this.y = value; } }

    public Cell()
    {
        content = 0;
        x = 0;
        y = 0;
    }

    public Cell(int v, int a, int b)
    {
        content = v;
        x = a;
        y = b;
    }
}

[ExecuteInEditMode]
public class Grid : MonoBehaviour
{
    private Cell[,] ground;
    private int numRows;
    private int numColumns;
    private GameController gc;
    public Field gcField;
    public int progressiveNumber;
    public Cell[,] GetGround()
    {
        return ground;
    }

    public int GetNumRows()
    {
        return numRows;
    }

    public void SetNumRows(int rows)
    {
        numRows = rows;
    }

    public int GetNumColumns()
    {
        return numColumns;
    }

    public void SetNumColumns(int columns)
    {
        numColumns = columns;
    }

    public void GetField()
    {
        gcField = gc.GetField();
        if (gcField != null)
        {
            //Debug.Log("GCfield is NOT NULL");
            for (int i = 0; i < numRows; i++)
            {
                for (int j = 0; j < numColumns; j++)
                {
                    ground[j, i] = new Cell(gcField.field[j, i], j, i);
                }
            }
        }
        //else
        //    Debug.Log("gcField is NULL");
    }

    void Awake()
    {
        //Debug.Log("Inizializzo la griglia");
        gc = GetComponent<GameController>();
        gcField = gc.GetField();
        numColumns = gc.numColumns;
        numRows = gc.numRows;
        progressiveNumber = gc.progressiveNumber;
        //Debug.Log("NUMRows = " + numRows);
        //Debug.Log("NUMCols = " + numColumns);
        ground = new Cell[numColumns, numRows];
        for (int i = 0; i < numRows; i++)
        {
            for (int j = 0; j < numColumns; j++)
            {
                ground[j, i] = new Cell();
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        GetField();
        //scrivi();
    }

    public void scrivi()
    {
        StreamWriter file = new StreamWriter(@"C:\Desktop\griglia.txt", true);
        for (int i=0; i<numRows; i++)
        {
            string text = "";
            for(int j=0; j<numColumns; j++)
            {
                text += ground[j, i].Content.ToString() + " ";
            }
            file.WriteLine(text);
        }
        file.WriteLine("--------------");
        file.Close();
    }
}