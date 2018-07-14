package myxml;

import java.io.*;
import java.util.*;

import org.w3c.dom.*;
import org.xml.sax.*;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

public class MyXML
{
	File f;
	Document doc;

	public void setDocument(File f) throws Exception
	{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();

		this.f = f;
		this.doc = builder.parse(f);
	}


	public Document getDocument()
	{
		return doc;
	}


	public Element getRoot()
	{
		return doc.getDocumentElement();
	}


	public Node getChild(Node parent, int index)
	{
		NodeList list = parent.getChildNodes();
		return list.item(index);
	}


	public int getIndexOfChild(Node parent, Node child)
	{
		NodeList list = parent.getChildNodes();

		for(int i=0; i<list.getLength(); i++)
		{
			if( getChild(parent,i) == child )
				return i;
		}

		return -1;
	}


	public void updateXML() throws Exception
	{
		TransformerFactory tf = TransformerFactory.newInstance();
		Transformer t = tf.newTransformer();
		t.transform(new DOMSource(doc), new StreamResult(f));
	}
}