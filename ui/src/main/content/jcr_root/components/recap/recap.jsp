<%@ page import="com.day.cq.widget.HtmlLibraryManager" %>
<%@ page import="net.adamcin.recap.addressbook.AddressBookConstants" %>
<%@ page import="net.adamcin.recap.addressbook.AddressBook" %>
<%--
  Recap Console component.
--%><%
%><%@page session="false" %><%
%><%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0" %><%
%><sling:defineObjects /><%
%><%
    AddressBook addressBook = resourceResolver.adaptTo(AddressBook.class);
    if (addressBook != null) {
        pageContext.setAttribute("addressBookPath", addressBook.getResource().getPath());
    } else {
        slingResponse.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
    }
%><!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Recap for Adobe CRX | <%=slingRequest.getRequestPathInfo().getSuffix()%></title>
    <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1">
    <%
        HtmlLibraryManager htmlMgr = sling.getService(HtmlLibraryManager.class);
        if (htmlMgr != null) {
            htmlMgr.writeIncludes(slingRequest, out, "recap");
        }
    %>
</head>
<body>
    <div data-role="globalheader" data-title="Recap" data-theme="a"></div>

    <div data-role="panel" data-id="menu" id="g-recap-menu">
        <div data-role="page" id="g-recap-address-book">
            <div data-role="header">
                <h1 class="g-uppercase">Address Book</h1>
            </div>

            <div data-role="content" data-scroll="y" data-theme="c">
                <ul id="address-list" data-role="listview" data-split-theme="c" data-split-icon="gear"></ul>
            </div>

        </div>
    </div>

    <textarea id="g-recap-address-book-tpl" style="display:none;">
        <li style="background:transparent;border-color:transparent;">
            <a x-cq-linkchecker="skip" data-role="button" data-theme="a" data-panel="main" href="${request.contextPath}{_g.recap.context.addressBookPath}/*.edit.html">
                Create Address
            </a>
        </li>
        {#foreach $T as address}
        <li>
            <a x-cq-linkchecker="skip" href="${request.contextPath}{$T.address.path}.html" data-panel="main">
                <h3>{$T.address.title}</h3>
                <p>{$T.address.url}</p>
            </a>
            <a x-cq-linkchecker="skip" href="${request.contextPath}{$T.address.path}.edit.html" data-panel="main">Edit</a>
        </li>
        {#/for}
    </textarea>

    <div data-role="panel" data-id="main" id="g-recap-main">
        <div data-role="page" id="g-recap-welcome">
            <div data-role="header">
            </div>

            <div data-role="content">
                <span class="g-big">Welcome to Recap</span>
            </div>
        </div>

        <div data-role="page" id="g-recap-console">
            <div data-role="content">
                <iframe name="console_frame" width="100%" height="100%"></iframe>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        (function() {
            _g.recap.reloadAddressBook();
            /*
            _g.$("#g-recap-addresses-menu").live("pageshow", function() {
            });
            */

            //_g.$.mobile.changePage("${addressBookPath}.html?:cK=" + (new Date()).getTime(), {pageContainer: _g.$("#g-recap-main")});
        })();
    </script>
</body>
</html>