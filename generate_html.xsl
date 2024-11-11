<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />
    
    <!-- Template principal para el documento -->
    <xsl:template match="/data">
        <html>
            <head>
                <title>Congress Page</title>
            </head>
            <body>
                <!-- Verifica si hay un error -->
                <xsl:choose>
                    <xsl:when test="error">
                        <h1 align="center">
                            <xsl:value-of select="error" />
                        </h1>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Encabezado del Congreso -->
                        <h1 align="center">
                            <xsl:value-of select="congress/name" />
                        </h1>
                        <h3 align="center">
                            From <xsl:value-of select="congress/period/@from" /> to <xsl:value-of select="congress/period/@to" />
                        </h3>
                        <hr />

                        <!-- Información de las Cámaras -->
                        <xsl:for-each select="congress/chambers/chamber">
                            <!-- Encabezado de la Cámara -->
                            <h2 align="center">
                                <xsl:value-of select="name" />
                            </h2>
                            
                            <!-- Tabla de Miembros -->
                            <h4 align="center">Members</h4>
                            <table border="1" align="center">
                                <thead bgcolor="grey">
                                    <tr>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>State</th>
                                        <th>Party</th>
                                        <th>Period</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="members/member">
                                        <tr>
                                            <td><img src="{image_url}" height="50" width="50" /></td>
                                            <td><xsl:value-of select="name" /></td>
                                            <td><xsl:value-of select="state" /></td>
                                            <td><xsl:value-of select="party" /></td>
                                            <td>From <xsl:value-of select="period/@from" /> to <xsl:value-of select="period/@to" /></td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>

                            <!-- Tabla de Sesiones -->
                            <h4 align="center">Sessions</h4>
                            <table border="1" align="center">
                                <thead bgcolor="grey">
                                    <tr>
                                        <th>Number</th>
                                        <th>Type</th>
                                        <th>Period</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="sessions/session">
                                        <tr>
                                            <td><xsl:value-of select="number" /></td>
                                            <td><xsl:value-of select="type" /></td>
                                            <td>From <xsl:value-of select="period/@from" /> to <xsl:value-of select="period/@to" /></td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>