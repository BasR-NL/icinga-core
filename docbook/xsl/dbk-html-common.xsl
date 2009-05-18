<?xml version="1.0" encoding="EUC-KR"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- �ں� �ѱ� ��Ÿ�Ͻ�Ʈ (http://kldp.net/projects/docbook/) -->
<!-- $Id: dbk-html-common.xsl,v 1.4 2003/08/11 04:24:06 minskim Exp $ -->

<xsl:import href="dbk-common.xsl"/>

<xsl:param name="email.nospam" select="'0'"/>

<!-- email.nospam�� '1'�� ������ ���, �̸��� �ּ��� '@'��
     ' (at) '���� ��ġ�Ѵ�. -->
<!-- xhtml/inline.xsl 1.31 -->
<xsl:template match="email">
  <xsl:call-template name="inline.monoseq">
    <xsl:with-param name="content">
      <xsl:text>&lt;</xsl:text>
      <xsl:choose>
        <xsl:when test="$email.nospam = '1' and substring-before(., '@') != ''">
          <xsl:value-of select="substring-before(., '@')"/> (at) <xsl:value-of select="substring-after(., '@')"/>      
        </xsl:when>
        <xsl:otherwise>
          <a xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="href">mailto:<xsl:value-of select="."/></xsl:attribute>
            <xsl:apply-templates/>
          </a>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>&gt;</xsl:text>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- author/email�� �ִ� ���, �̸� �ڿ� �̸��� �ּҸ� ����Ѵ�. -->
<!-- xhtml/titlepage.xsl 1.23 -->
<xsl:template match="author" mode="titlepage.mode">
  <div xmlns="http://www.w3.org/1999/xhtml" class="{name(.)}">
    <h3 class="{name(.)}">
      <xsl:call-template name="person.name"/>
      <!-- �̸� �ڿ� �̸��� �ּ� ��� -->
      <xsl:choose>
        <xsl:when test="./email">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="./email"/>
        </xsl:when>
      </xsl:choose>
    </h3>
    <xsl:apply-templates mode="titlepage.mode" select="./contrib"/>
    <xsl:apply-templates mode="titlepage.mode" select="./affiliation"/>
  </div>
</xsl:template>

<!-- othercredit/email�� �ִ� ���, �̸� �ڿ� �̸��� �ּҸ� ����Ѵ�. -->
<!-- xhtml/titlepage.xsl 1.23 -->
<xsl:template match="othercredit" mode="titlepage.mode">
  <xsl:variable name="contrib" select="string(contrib)"/>
  <xsl:choose>
    <xsl:when test="contrib">
      <xsl:if test="not(preceding-sibling::othercredit[string(contrib)=$contrib])">
        <xsl:call-template name="paragraph">
          <xsl:with-param name="class" select="name(.)"/>
          <xsl:with-param name="content">
            <xsl:apply-templates mode="titlepage.mode" select="contrib"/>
            <xsl:text>: </xsl:text>
            <xsl:call-template name="person.name"/>
            <!-- �̸� �ڿ� �̸��� �ּ� ��� -->
            <xsl:choose>
              <xsl:when test="email">
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="email"/>
              </xsl:when>
            </xsl:choose>
            <xsl:apply-templates mode="titlepage.mode" select="./affiliation"/>
            <xsl:apply-templates select="following-sibling::othercredit[string(contrib)=$contrib]" mode="titlepage.othercredits"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="paragraph">
        <xsl:with-param name="class" select="name(.)"/>
        <xsl:with-param name="content">
          <xsl:call-template name="person.name"/>
          <!-- �̸� �ڿ� �̸��� �ּ� ��� -->
          <xsl:choose>
            <xsl:when test="email">
              <xsl:text> </xsl:text>
              <xsl:apply-templates select="email"/>
            </xsl:when>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates mode="titlepage.mode" select="./affiliation"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
