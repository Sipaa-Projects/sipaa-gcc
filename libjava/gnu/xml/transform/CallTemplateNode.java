/* CallTemplateNode.java -- 
   Copyright (C) 2004 Free Software Foundation, Inc.

This file is part of GNU Classpath.

GNU Classpath is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

GNU Classpath is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Classpath; see the file COPYING.  If not, write to the
Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 USA.

Linking this library statically or dynamically with other modules is
making a combined work based on this library.  Thus, the terms and
conditions of the GNU General Public License cover the whole
combination.

As a special exception, the copyright holders of this library give you
permission to link this library with independent modules to produce an
executable, regardless of the license terms of these independent
modules, and to copy and distribute the resulting executable under
terms of your choice, provided that you also meet, for each linked
independent module, the terms and conditions of the license of that
module.  An independent module is a module which is not derived from
or based on this library.  If you modify this library, you may extend
this exception to your version of the library, but you are not
obligated to do so.  If you do not wish to do so, delete this
exception statement from your version. */

package gnu.xml.transform;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.xml.namespace.QName;
import javax.xml.transform.TransformerException;
import org.w3c.dom.Node;

/**
 * A template node representing the XSL <code>call-template</code>
 * instruction.
 *
 * @author <a href='mailto:dog@gnu.org'>Chris Burdess</a>
 */
final class CallTemplateNode
  extends TemplateNode
{

  final QName name;
  final List withParams;

  CallTemplateNode(TemplateNode children, TemplateNode next,
                   QName name, List withParams)
  {
    super(children, next);
    this.name = name;
    this.withParams = withParams;
  }

  TemplateNode clone(Stylesheet stylesheet)
  {
    int len = withParams.size();
    List withParams2 = new ArrayList(len);
    for (int i = 0; i < len; i++)
      {
        withParams2.add(((WithParam) withParams.get(i)).clone(stylesheet));
      }
    return new CallTemplateNode((children == null) ? null :
                                children.clone(stylesheet),
                                (next == null) ? null :
                                next.clone(stylesheet),
                                name, withParams2);
  }

  void doApply(Stylesheet stylesheet, QName mode,
               Node context, int pos, int len,
               Node parent, Node nextSibling)
    throws TransformerException
  {
    if (withParams != null)
      {
        // push the parameter context
        stylesheet.bindings.push(false);
        // set the parameters
        for (Iterator i = withParams.iterator(); i.hasNext(); )
          {
            WithParam p = (WithParam) i.next();
            Object value = p.getValue(stylesheet, mode, context, pos, len);
            stylesheet.bindings.set(p.name, value, false);
          }
      }
    TemplateNode t = stylesheet.getTemplate(mode, name);
    if (t != null)
      {
        t.apply(stylesheet, mode, context, pos, len,
                parent, nextSibling);
      }
    if (withParams != null)
      {
        // pop the variable context
        stylesheet.bindings.pop(false);
      }
    // call-template doesn't have processable children
    if (next != null)
      {
        next.apply(stylesheet, mode,
                   context, pos, len,
                   parent, nextSibling);
      }
  }
  
  public String toString()
  {
    StringBuffer buf = new StringBuffer(getClass().getName());
    buf.append('[');
    buf.append("name=");
    buf.append(name);
    buf.append(']');
    return buf.toString();
  }
  
}
